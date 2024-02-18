/**
 * 网络请求框架
 */
import http from '@ohos.net.http';
import Response from '../network/entity/Response';
import Constants from './Constants';
import Logger from './Logger';
import { PreferencesUtil } from './PreferencesUtil';
import SpKey from './SpKey';

export async function request(url: string, method: http.RequestMethod, data?: any): Promise<Response> {

  let base_url = await getBase()
  let httpRequest = http.createHttp()
  let responseResult = httpRequest.request(base_url + url, {
    method: method,
    extraData: JSON.stringify(data)
  })

   let response = new Response();
  // 处理数据，并返回
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === 200) {
      // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
      // 这里建议和后端的保持一致
      let res: Response = JSON.parse(`${value.result}`);
      response.data = res.data;
      response.code = res.code;
      response.message = res.message;
    } else {
      response.message = '请求错误';
      response.code = 400;
    }
    return response;
  }).catch(() => {
    response.message = '请求错误';
    response.code = 400;
    return response;
  });

}

 function getBase(): Promise<string> {
   return new Promise((resolve, reject) => {
     PreferencesUtil.get(SpKey.BASE_URL).then((value: string) => {
       Logger.debug(Constants.TAG, `get: ${value}`);
       resolve(value);
     }).catch((error) => {
       reject(error);
     });
   });
}




