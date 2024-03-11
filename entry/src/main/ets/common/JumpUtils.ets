import router from '@ohos.router';

export class JumpUtils{

  public jumpToLoginHome(){
    router.replaceUrl({
      url: 'pages/LoginHome'
    });
  }

}

export default new JumpUtils();