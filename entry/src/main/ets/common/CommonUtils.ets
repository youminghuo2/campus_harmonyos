/**
 * 公共方法
 */
import cryptoFramework from '@ohos.security.cryptoFramework';
import Constants from './Constants';
import Logger from './Logger';
import { PreferencesUtil } from './PreferencesUtil';
import SpKey from './SpKey';

export class CommonUtils {

  /**
   * 检查手机号
   */
  public checkIsPhone(phoneNumber: string): boolean {
    let check = /^1[3-9]\d{9}$/;
    return check.test(phoneNumber)
  }

  /**
   * 判断账号密码是否都不为空
   * 如果两个都不为空，则返回true，否则返回false
   */
  public checkIsNotEmptyLogin(account: string, psd: string): boolean {
    return!this.checkIsEmpty(account) && !this.checkIsEmpty(psd)
  }

  /**
   * 检查字符串是否为空
   */
  public checkIsEmpty(str: string): boolean {
    return!str || str.trim().length == 0
  }

  /*
   * md5加密
   */
  public async getMd5String(content: string): Promise<string> {
    let md5 = cryptoFramework.createMd("MD5");
    md5.update({ data: this.stringToUnit8Array(content) });

    return new Promise((resolve, reject) => {
      md5.digest((_err1, mdOutput) => {
        console.log("[Promise]: MD result: " + mdOutput.data);
        const hexString = this.uint8ArrayToHexString(mdOutput.data);
        const md5String = hexString.toLowerCase().substring(0, 32);
        resolve(md5String);
        Logger.debug(Constants.TAG, `md5String  is ${md5String}`)
      });
    });
  }

  private uint8ArrayToHexString(uint8Array: Uint8Array): string {
    let hexString = '';
    for (let i = 0; i < uint8Array.length; i++) {
      let hex = (uint8Array[i] & 0xff).toString(16);
      hex = hex.length === 1 ? '0' + hex : hex;
      hexString += hex;
    }
    return hexString;
  }

  private stringToUnit8Array(str: string): Uint8Array {
    var arr = [];
    for (var i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    var tmpUnit8Array = new Uint8Array(arr);
    return tmpUnit8Array;
  }

  //获取token和schoolId
  public  async getTokenOrSchoolId():Promise<Map<string, string>> {
    let map = new Map<string, string>()
    await Promise.all([
    PreferencesUtil.get(SpKey.token).then((data: string) => {
      if (data!=null) {
        map.set("Auth-JWT", data)
      }
    }),
    PreferencesUtil.get(SpKey.schoolId).then((data: string) => {
      if(data!=null){
        map.set("aware_organization_uid", data)
      }
    })
    ]);
    map.forEach((value,key)=>{
      Logger.debug(Constants.TAG,"打印的map getTokenOrSchoolId 为:"+key+":"+value)
    })
    return map;

  }



}

export default new CommonUtils();