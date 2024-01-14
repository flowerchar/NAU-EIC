import request from '@/utils/request'

export const DataService = (params) => {
  const beginDate = new Date(params.beginDate.value).toISOString().split('T')[0]
  const endDate = new Date(params.endDate.value).toISOString().split('T')[0]
  const queryString = `?begin=${beginDate}&end=${endDate}&region=${encodeURIComponent(
    params.region.value
  )}`
  return request.get('/getSpecifyDateAndRegionNews' + queryString)
}

export const TopDataService = (params) => {
  const beginDate = new Date(params.beginDate.value).toISOString().split('T')[0]
  const endDate = new Date(params.endDate.value).toISOString().split('T')[0]
  const queryString = `?begin=${beginDate}&end=${endDate}&region=${encodeURIComponent(
    params.region.value
  )}`
  return request.get('/getSpecifyDateAndRegionTop' + queryString)
}
