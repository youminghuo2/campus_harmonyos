/**
 * 公共方法
 */
import cryptoFramework from '@ohos.security.cryptoFramework';
import Constants from './Constants';
import Logger from './Logger';
export class CommonUtils {

  /**
   * 检查手机号
   */
  public checkIsPhone(phoneNumber: string): boolean {
    let check = /^1[3-9]\d{9}$/;
    return check.test(phoneNumber)
  }

  /**
   * 判断账号密码是否为空
   * 如果两个都不为空，则返回true，否则返回false
   */
  public checkIsEmptyLogin(account: string, psd: string): boolean {
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

}

export default new CommonUtils();