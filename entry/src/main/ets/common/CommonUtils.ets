/**
 * 公共方法
 */
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

}

export default new CommonUtils();