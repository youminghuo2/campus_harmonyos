/**
 * 网络请求框架
 * data如果是GET形式，data此时等同于以Map<String,Object>形式传递
 */
import http from '@ohos.net.http';
import Response from '../network/entity/Response';

import CommonUtils from './CommonUtils';
import Constants from './Constants';
import Logger from './Logger';
import { PreferencesUtil } from './PreferencesUtil';
import SpKey from './SpKey';

export async function request(url: string, method: http.RequestMethod, data?: any): Promise<Response> {

  let base_url = await getBase()
  let httpRequest = http.createHttp()

  if (method === http.RequestMethod.GET && data instanceof Map) {
    const urlParams = Object.keys(data).map(key => `${key}=${data[key]}`).join('&');
    url = url.includes('?') ? `${url}${urlParams}` : `${url}?${urlParams}`;
  }
  Logger.debug(Constants.TAG, `base url 请求完整地址 is ${base_url + url}`)

  let responseResult = httpRequest.request(base_url + url, {
    method: method,
    extraData: method == http.RequestMethod.GET ? undefined : JSON.stringify(data)
  })

  let response = new Response();
  Logger.debug(Constants.TAG, `response url is ${url}`)
  // 处理数据，并返回
    return responseResult.then((value: http.HttpResponse) => {

    Logger.debug(Constants.TAG, `response header is ${value.header}`)
    Logger.debug(Constants.TAG, `response responseCode is ${value.responseCode}`)
    Logger.debug(Constants.TAG, `response resultType is ${value.resultType}`)
    if (value.responseCode === 200) {
      // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
      // 这里建议和后端的保持一致
      let res: Response = JSON.parse(`${value.result}`);
      response.data = res.data;
      response.code = res.code;
      response.message = res.message;
      tagLog(response)
    } else {
      tagLog(response)
      response.message = '请求错误';
      response.code = 400;
    }
    return response;
  }).catch(() => {
    tagLog(response)
    response.message = '请求错误';
    response.code = 400;
    return response;
  });

}

function tagLog(response: Response) {
  Logger.debug(Constants.TAG, `response code is ${response.code}`)
  Logger.debug(Constants.TAG, `response message is ${response.message}`)
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




