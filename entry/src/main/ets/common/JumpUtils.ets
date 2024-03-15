import router from '@ohos.router';
import Constants from './Constants';
import Logger from './Logger';

/**
 * 跳转页面
 */
export class JumpUtils{

  //跳转登录页
  public jumpToLoginHome(){
    router.replaceUrl({
      url: 'pages/LoginHomePage'
    });
  }

  //跳转主页
  public jumpToMainPage(){
    router.replaceUrl({
      url: 'pages/MainPage',
    }), (err) => {
      if (err) {
        Logger.error(Constants.TAG, `push to MainPage is failed,code is ${err.code},message is ${err.message}`);
        return;
      }
      Logger.debug(Constants.TAG, `push to MainPage is success`)
    }
  }

  //跳转webView
  public JumpToWebView(url:string,title:Resource){
    router.pushUrl({
      url: 'pages/WebView',
      params: {
        url: url,
        title: title
      }
    }), (err => {
      if (err) {
        Logger.error(Constants.TAG, ` push to WebviewPage is failed,code is ${err.code},message is ${err.message}`);
        return;
      }
      Logger.debug(Constants.TAG, `push to WebviewPage is success`)
    });
  }


  //跳转注册界面
  public JumpToRegisterPage(){
    router.pushUrl({
      url: 'pages/RegisterPage',
    }), (err) => {
      if (err) {
        Logger.error(Constants.TAG, `push to register is failed,code is ${err.code},message is ${err.message}`);
        return;
      }
      Logger.debug(Constants.TAG, `push to register is success`)
    }
  }

  //跳转家长账号注册接收二维码界面
  public JumpToRegisterSmsPage(phone:string){
    router.pushUrl({
      url: 'pages/RegisterSmsPage',
      params:{
        "phone":phone
      }
    }), (err) => {
      if (err) {
        Logger.error(Constants.TAG, `push to registerSmsPage is failed,code is ${err.code},message is ${err.message}`);
        return;
      }
      Logger.debug(Constants.TAG, `push to registerSmsPage is success`)
    }
  }

}

export default new JumpUtils();