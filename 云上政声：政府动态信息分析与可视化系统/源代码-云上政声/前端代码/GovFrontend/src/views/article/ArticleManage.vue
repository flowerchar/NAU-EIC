<script lang="ts" setup>
import { ref } from 'vue'
import * as echarts from 'echarts'
import { TopDataService } from '@/api/data.js'
const region = ref('')
const beginDate = ref('')
const endDate = ref('')
// function splitText(locales, text) {
//   console.table(Array.from(new Intl.Segmenter(locales, { granularity: 'word' }).segment(text)))
// }
const getDataList = async () => {
  const res = await TopDataService({ beginDate, endDate, region })
  console.log(res.data.data)
  let keysArray = Object.keys(res.data.data)

  // 提取所有的值为一个数组
  let valuesArray = Object.values(res.data.data)

  var chartDom1 = document.getElementById('main1')
  var myChart1 = echarts.init(chartDom1)
  var option1
  let yMax = 500
  let dataShadow = []
  for (let i = 0; i < valuesArray.length; i++) {
    dataShadow.push(yMax)
  }
  option1 = {
    title: {
      text: 'Top10关键词展示',
      subtext: '鼠标左击可以缩放'
    },
    xAxis: {
      data: keysArray,
      axisLabel: {
        inside: true,
        color: '#fff'
      },
      axisTick: {
        show: false
      },
      axisLine: {
        show: false
      },
      z: 10
    },
    yAxis: {
      axisLine: {
        show: false
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        color: '#999'
      }
    },
    dataZoom: [
      {
        type: 'inside'
      }
    ],
    series: [
      {
        type: 'bar',
        showBackground: true,
        itemStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: '#83bff6' },
            { offset: 0.5, color: '#188df0' },
            { offset: 1, color: '#188df0' }
          ])
        },
        emphasis: {
          itemStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: '#2378f7' },
              { offset: 0.7, color: '#2378f7' },
              { offset: 1, color: '#83bff6' }
            ])
          }
        },
        data: valuesArray
      }
    ]
  }
  // Enable data zoom when user click bar.
  const zoomSize = 6
  myChart1.on('click', function (params) {
    console.log(keysArray[Math.max(params.dataIndex - zoomSize / 2, 0)])
    myChart1.dispatchAction({
      type: 'dataZoom',
      startValue: keysArray[Math.max(params.dataIndex - zoomSize / 2, 0)],
      endValue: keysArray[Math.min(params.dataIndex + zoomSize / 2, valuesArray.length - 1)]
    })
  })

  option1 && myChart1.setOption(option1)

  var chartDom = document.getElementById('main2')
  var myChart = echarts.init(chartDom)
  var option

  option = {
    title: {
      text: 'Top10关键字饼图展示',
      subtext: '鼠标悬浮可查看数值',
      left: 'center'
    },
    tooltip: {
      trigger: 'item'
    },
    legend: {
      orient: 'vertical',
      left: 'left'
    },
    series: [
      {
        name: 'Access From',
        type: 'pie',
        radius: '50%',
        data: [
          { value: valuesArray[0], name: keysArray[0] },
          { value: valuesArray[1], name: keysArray[1] },
          { value: valuesArray[2], name: keysArray[2] },
          { value: valuesArray[3], name: keysArray[3] },
          { value: valuesArray[4], name: keysArray[4] },
          { value: valuesArray[5], name: keysArray[5] },
          { value: valuesArray[6], name: keysArray[6] },
          { value: valuesArray[7], name: keysArray[7] },
          { value: valuesArray[8], name: keysArray[8] },
          { value: valuesArray[9], name: keysArray[9] }
        ],
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ]
  }

  option && myChart.setOption(option)
}

const onSearch = () => {
  getDataList()
}
const option1s = [
  {
    value: '贵阳',
    label: '贵阳'
  },
  {
    value: '遵义',
    label: '遵义'
  },
  {
    value: '六盘水',
    label: '六盘水'
  },
  {
    value: '安顺',
    label: '安顺'
  },
  {
    value: '铜仁',
    label: '铜仁'
  },
  {
    value: '毕节',
    label: '毕节'
  },
  {
    value: '黔东南',
    label: '黔东南'
  },
  {
    value: '黔南',
    label: '黔南'
  },
  {
    value: '黔西南',
    label: '黔西南'
  }
]
</script>

<template>
  <page-container title="市州区县">
    <el-form inline>
      <el-form-item>
        <el-date-picker v-model="beginDate" type="date" placeholder="选择起始时间:" />
      </el-form-item>
      <el-form-item>
        <el-date-picker v-model="endDate" type="date" placeholder="选择截止时间:" />
      </el-form-item>

      <el-form-item label="所属地区">
        <el-select v-model="region">
          <el-option
            v-for="item in option1s"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSearch">生成图表</el-button>
      </el-form-item>
    </el-form>

    <div class="container">
      <div id="main1" style="width: 500px; height: 300px" class="box"></div>
      <div id="main2" style="width: 500px; height: 300px" class="box"></div>
    </div>
  </page-container>
</template>

<style scoped>
.container {
  display: flex;
}

.box {
  width: 50%; /* 或者根据实际需要设置具体的宽度 */
  border: 1px solid #ccc;
  padding: 10px;
  box-sizing: border-box;
}
</style>
