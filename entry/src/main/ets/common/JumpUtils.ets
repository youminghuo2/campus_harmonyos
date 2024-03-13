import router from '@ohos.router';
import Constants from './Constants';
import Logger from './Logger';

/**
 * 跳转页面
 */
export class JumpUtils{

  public jumpToLoginHome(){
    router.replaceUrl({
      url: 'pages/LoginHomePage'
    });
  }

  public jumpToMainPage(){
    router.replaceUrl({
      url: 'pages/MainPage',
    }), router.RouterMode.Standard, (err) => {
      if (err) {
        Logger.error(Constants.TAG, `LoginHome push to MainPage is failed,code is ${err.code},message is ${err.message}`);
        return;
      }
      Logger.debug(Constants.TAG, ` LoginHome push to MainPage is success`)
    }
  }

}

export default new JumpUtils();