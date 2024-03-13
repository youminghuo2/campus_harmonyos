
import http from '@ohos.net.http'
import { request } from '../../common/HttpUtils'

//账号密码登录
export function getLoginPsdList(data){
  return request(`basicdata/index/login/bypwd`,http.RequestMethod.GET,data)
}

//获取登录用户信息
export function getLoginInfo(header){
  return request(`basicdata/common/loginuserinfo`,http.RequestMethod.GET,null,header)
}

// //获取验证码
export function sendSmsCode(data){
  return request(`basicdata/index/login/bysmsvcode/sendsmsvcode`,http.RequestMethod.GET,data)
}

//验证码登录
export function getLoginSmsList(data){
  return request(`basicdata/index/login/bysmsvcode`,http.RequestMethod.GET,data)
}

//注册发送验证码
export function registerSmsCode(data){
  return request(`basicdata/index/regist/bymobile/sendsmsvcode`,http.RequestMethod.GET,data)
}

