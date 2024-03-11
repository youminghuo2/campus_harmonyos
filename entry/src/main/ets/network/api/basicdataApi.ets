
import http from '@ohos.net.http'
import { request } from '../../common/HttpUtils'

//账号密码登录
export function getLoginPsdList(data){
  return request(`basicdata/index/login/bypwd`,http.RequestMethod.GET,data)
}

//获取登录用户信息
export function loginuInfo(header){
  return request(`basicdata/common/loginuserinfo`,http.RequestMethod.GET,null,header)
}

