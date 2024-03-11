import http from '@ohos.net.http'
import { request } from '../../common/HttpUtils'

//获取app模块
export function getAppmodule(data,header){
  return request(`portal/shareentry/app/client/module`,http.RequestMethod.GET,data,header)
}

//根据模块获取图片列表
export function getBylication(data){
  return request(`portal/index/poster/list/bylocation`,http.RequestMethod.GET,data)
}