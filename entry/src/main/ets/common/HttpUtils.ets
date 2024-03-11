/**
 * 网络请求框架
 * data如果是GET形式，data此时等同于以Map<String,Object>形式传递
 */
import http from '@ohos.net.http';
import promptAction from '@ohos.promptAction';
import Response from '../network/entity/Response';

import CommonUtils from './CommonUtils';
import Constants from './Constants';
import Logger from './Logger';
import { PreferencesUtil } from './PreferencesUtil';
import SpKey from './SpKey';

export async function request(url: string, method: http.RequestMethod, data?: any,header?:any): Promise<Response> {

  let base_url = await getBase()
  let httpRequest = http.createHttp()

  if (method === http.RequestMethod.GET && data instanceof Map) {

    let urlParams = ""
    Logger.debug(Constants.TAG, `---------------------------------------------------------------------------------------------------`)
    for (let [key, value] of data) {
      urlParams += `${key}=${value}&`;
      Logger.debug(Constants.TAG, `对应的参数 is ${"key: "+key +" value: " +value}`)
    }
    if (urlParams.length > 0) {
      urlParams = urlParams.substring(0, urlParams.length - 1);
    }
    Logger.debug(Constants.TAG, `urlParams 请求的参数完整参数 is ${urlParams}`)
    Logger.debug(Constants.TAG, `---------------------------------------------------------------------------------------------------`)

    url = url.includes('?') ? `${url}&${urlParams}` : `${url}?${urlParams}`;
  }

  Logger.debug(Constants.TAG, `base url 请求地址 is ${base_url + url}`)

  // let a=header instanceof Map && header.size > 0 ? header:undefined;

  let responseResult = httpRequest.request(base_url + url, {
    header: header instanceof Map && header.size>0 ? header:undefined,
    method: method,
    extraData: method == http.RequestMethod.GET ? undefined : JSON.stringify(data)
  })

  let response = new Response();

  // 处理数据，并返回
  return responseResult.then((value: http.HttpResponse) => {
    Logger.debug(Constants.TAG, `---------------------------------------------------------------------------------------------------`)
    Logger.debug(Constants.TAG, `response header is ${JSON.stringify(value.header)}`)
    Logger.debug(Constants.TAG, `response responseCode is ${value.responseCode}`)
    if (value.responseCode === 200) {

      let res: Response = JSON.parse(`${value.result}`);
      response.data = res.data;
      response.code = res.code;
      response.msg = res.msg;
      tagLog(response)
      if (response.code == Constants.SUCCESS) {

        PreferencesUtil.get(SpKey.token).then((headerData: string) => {
          if (CommonUtils.checkIsEmpty(headerData)) {
            saveTokenAndRefresh(JSON.stringify(value.header))
          }
        })

        // promptAction.showToast({ message: response.msg })
        Logger.debug(Constants.TAG, `接口结果:${response.msg}`)
        return response;
      }if (response.code == Constants.FAILURE) {
        promptAction.showToast({ message: response.msg })
        return response;
      }
    } else {
      tagLog(response)
      // response.msg = '请求错误';
      // response.code = 400;
    }
    return response;
  }).catch(() => {
    tagLog(response)
    // response.msg = '请求错误';
    // response.code = 400;
    promptAction.showToast({ message: response.msg })
    return response;
  });
  Logger.debug(Constants.TAG, `---------------------------------------------------------------------------------------------------`)
}

function tagLog(response: Response) {
  Logger.debug(Constants.TAG, `response code is ${response.code}`)
  Logger.debug(Constants.TAG, `response msg is ${response.msg}`)
  Logger.debug(Constants.TAG, `response data is ${JSON.stringify(response.data)}`)

}

function getBase(): Promise<string> {
  return new Promise((resolve, reject) => {
    PreferencesUtil.get(SpKey.BASE_URL).then((value: string) => {
      Logger.debug(Constants.TAG, `get: ${value}`);
      if (CommonUtils.checkIsEmpty(value)) {
        value = Constants.BASE_URL
        PreferencesUtil.put(SpKey.BASE_URL, value)
      }
      resolve(value);
    }).catch((error) => {
      reject(error);
    });
  });
}

function saveTokenAndRefresh(data:string){
  let obj=JSON.parse(data.toString());

  Logger.debug(Constants.TAG, `---------------------------------------------------------------------------------------------------`)
  Logger.debug(Constants.TAG, `saveTokenAndRefresh token is ${ obj['auth-jwt']}`)
  Logger.debug(Constants.TAG, `saveTokenAndRefresh refreshToken is ${ obj['auth-jwt']}`)
  PreferencesUtil.put(SpKey.token,obj['auth-jwt'])
  PreferencesUtil.put(SpKey.refresh_token,obj['auth-jwt-refresh'])

}




