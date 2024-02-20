
import http from '@ohos.net.http'
import { request } from '../../common/HttpUtils'

//账号密码登录
export function getLoginPsdList(data){
  return request(`basicdata/index/login/bypwd`,http.RequestMethod.GET,data)
}