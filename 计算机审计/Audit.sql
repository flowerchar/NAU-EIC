select * from GL_accvouch 
where ccode =1001 and mc>1000

SELECT t1.ino_id AS '凭证号',
    t1.csign AS '凭证类别字',
    t1.ccode AS '科目编码',
    t1.ccode_equal AS '对方科目',
    t1.md AS '金额借方',
    t1.mc AS '金额贷方',
    t1.cbill AS '制单人',
    t1.iperiod AS '会计期间'
FROM GL_accvouch t1
INNER JOIN (
    SELECT DISTINCT ino_id, csign, iperiod
    FROM GL_accvouch
    WHERE ccode = '1122'			
) t2 ON t1.ino_id = t2.ino_id 
	AND t1.csign = t2.csign 
	AND t1.iperiod = t2.iperiod		
INNER JOIN GL_accvouch t3 ON t1.ino_id = t3.ino_id
    AND t1.csign = t3.csign
    AND t1.iperiod = t3.iperiod
    AND t3.ccode LIKE '6001%'

SELECT t1.iperiod AS '会计期间',
       SUM(t1.md) AS '金额借方总计',
       SUM(t1.mc) AS '金额贷方总计'
FROM GL_accvouch t1
INNER JOIN (
    SELECT DISTINCT ino_id, csign, iperiod
    FROM GL_accvouch
    WHERE ccode = '1122'			
) t2 ON t1.ino_id = t2.ino_id 
	AND t1.csign = t2.csign 
	AND t1.iperiod = t2.iperiod		
INNER JOIN GL_accvouch t3 ON t1.ino_id = t3.ino_id
    AND t1.csign = t3.csign
    AND t1.iperiod = t3.iperiod
    AND t3.ccode LIKE '6001%'		
	GROUP BY t1.iperiod
ORDER BY t1.iperiod

SELECT	t1.ino_id AS '凭证号',
		t1.csign AS '凭证类别字',
		t1.ccode AS '科目编码',
		t1.ccode_equal AS '对方科目',
		t1.md AS '金额借方',
		t1.mc AS '金额贷方',
		t1.cbill AS '制单人',
		t1.iperiod AS '会计期间',
		t2.ccode AS '增值税记录'
	FROM (SELECT *
			FROM GL_accvouch a
			WHERE ccode = '6001') t1
			LEFT JOIN (SELECT *
			FROM GL_accvouch
			WHERE ccode LIKE '2221%') t2 
		ON  t1.ino_id = t2.ino_id AND t1.csign = t2.csign AND t1.iperiod = t2.iperiod;

SELECT  t1.ino_id AS '凭证号',
		t1.csign AS '凭证类别字',
		t1.ccode AS '科目编码',
		t1.ccode_equal AS '对方科目',
		t1.md AS '金额借方',
		t1.mc AS '金额贷方',
		t1.cbill AS '制单人',
		t1.iperiod AS '会计期间',
		t1.coutno_id AS '发票号',
		t2.cClue AS '对应发票号'
	FROM GL_accvouch t1
	LEFT JOIN salebillvouchs t2
	ON coutno_id  =  cClue

SELECT  t1.cDLCode AS '发货单号',
		t2.cClue AS '销售发票号',
		t3.ino_id AS '凭证号',
		t3.ccode AS '入账科目'
	FROM (DispatchList t1
		LEFT JOIN SaleBillVouchs t2
		ON t1.cSOCode=t2.cSOCode)	
	LEFT JOIN GL_accvouch t3
		ON t3.coutno_id = t2.cClue