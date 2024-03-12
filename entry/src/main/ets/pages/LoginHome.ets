import CommonUtils from '../common/CommonUtils'
import Logger from '../common/Logger'
import { getLoginPsdList } from '../network/api/basicdataApi'
import bundleManager from '@ohos.bundle.bundleManager';
import Constants from '../common/Constants';
import deviceInfo from '@ohos.deviceInfo';
import OneBtnDialog from '../frame/dialog/OneBtnDialog';
import router from '@ohos.router';
import { PreferencesUtil } from '../common/PreferencesUtil';
import SpKey from '../common/SpKey';
import TwoBtnDialog from '../frame/dialog/TwoBtnDialog';

/**
 * 登录主界面
 */
@Entry
@Component
struct LoginHome {
  @State message: string = 'Hello World'
  @State checked: string = "psd"
  @State isLogin: boolean = false
  @State accountText: string = ""
  @State psdText: string = ""
  //当前的模式是账号密码，或者短信
  @State mode: string = "psd"
  //checkbox是否勾选
  @State privacy_checkOn: boolean = false
  private count: number = 0


  //弹窗
  private psd_wrongText = '账号或密码错误，请重新输入'
  psdWrongController: CustomDialogController = new CustomDialogController({
    builder: OneBtnDialog({
      content: this.psd_wrongText,
      positive: () => {
        this.psdWrongController.close()
      }
    })
  })

  private privacy_Text = '请先勾选同意下方协议'
  privacyController: CustomDialogController = new CustomDialogController({
    builder: OneBtnDialog({
      content: this.privacy_Text,
      positive: () => {
        this.privacyController.close()
      }
    })
  })

  private no_registerText='该手机号码未注册，请先注册'
  noRegisterController:CustomDialogController=new CustomDialogController({
      builder:TwoBtnDialog({
        content: this.no_registerText,
        positive: () => {
          this.noRegisterController.close()
        },
        negative:()=>{
         this. noRegisterController.close()
        }
      })
  })

  async aboutToAppear() {
    let data = await PreferencesUtil.getEntity(SpKey.splashImgList)
    Logger.debug(Constants.TAG, `轮播图s data` + JSON.stringify(data))
  }

  build() {
    Column() {
      Image($r('app.media.close')).width('18vp').height('18vp').margin({
        top: '20vp'
      })

      Text($r('app.string.LoginHome_title'))
        .fontSize('27fp')
        .fontColor($r('app.color.color_353535'))
        .fontWeight(FontWeight.Bold)
        .margin({
          top: '38vp'
        })

      Row() {
        Text('psd') {
          Span('账号密码')
            .decoration(this.checked == 'psd' ? {
                                                  type: TextDecorationType.Underline,
                                                  color: $r('app.color.color_17B9C5')
                                                } : {
                                                      type: TextDecorationType.None,
                                                      color: $r('app.color.white')
                                                    })
            .fontSize(15)
            .fontColor(this.checked == 'psd' ? $r('app.color.color_17B9C5') : $r('app.color.color_353535'))
        }
        .onClick(() => {
          this.checked = 'psd'
          if (this.mode == 'sms') {
            this.mode = 'psd'
            this.accountText = ''
            this.psdText = ''
            this.count = 0
          }
        })

        Text('sms') {
          Span('短信验证')
            .decoration(this.checked == 'sms' ? {
                                                  type: TextDecorationType.Underline,
                                                  color: $r('app.color.color_17B9C5')
                                                } : {
                                                      type: TextDecorationType.None,
                                                      color: $r('app.color.white')
                                                    })
            .fontSize(15)
            .fontColor(this.checked == 'sms' ? $r('app.color.color_17B9C5') : $r('app.color.color_353535'))
        }
        .onClick(() => {
          this.checked = 'sms'
          if (this.mode == 'psd') {
            this.mode = 'sms'
            this.accountText = ''
            this.psdText = ''
            this.count = 0
          }
        }).margin({
          left: '30vp'
        })

      }.width('100%')
      .margin({
        top: '30vp',
      })

      Row() {
        Image(this.checked == 'psd' ? $r('app.media.account') : $r('app.media.phone')).width(20)

        //手机号码
        TextInput({
          placeholder: this.checked == 'psd' ? $r('app.string.phone_input') : $r('app.string.sms_verity'),
          text: this.accountText
        })
          .style(TextInputStyle.Inline)
          .border({ width: 0 })
          .backgroundColor(Color.White)
          .id('input_account')
          .onChange((value: string) => {
            this.accountText = value
            Logger.debug('账号', this.accountText)
          })

      }.margin({
        top: '20vp',
      })

      Divider().strokeWidth('1vp').color($r('app.color.line_color'))

      Row() {
        Image(this.checked == 'psd' ? $r('app.media.psd') : $r('app.media.smsPsd')).width(20)

        //密码或验证码
        TextInput({
          placeholder: this.checked == 'psd' ? $r('app.string.psd_input') : $r('app.string.smsPsd_input'),
          text: this.psdText
        })
          .type(this.mode == 'psd' ? InputType.Password : InputType.Number)
          .style(TextInputStyle.Inline)
          .border({ width: 0 })
          .backgroundColor(Color.White)
          .width(this.mode == 'psd' ? '95%' : '60%')
          .id('input_psd')
          .onChange((value: string) => {
            this.psdText = value
            Logger.debug('密码', this.psdText)
          })

        Text('获取验证码')
          .visibility(this.checked == 'sms' ? Visibility.Visible : Visibility.Hidden)
          .textAlign(TextAlign.End)
          .width('30%')
          .fontSize(16)
          .fontColor($r('app.color.color_CCCCCC'))

      }.margin({
        top: '15vp',
      })

      Divider().margin({}).strokeWidth('1vp').color($r('app.color.line_color'))

      Button($r('app.string.login_at'), {
        type: ButtonType.Normal
      })
        .borderRadius(8)
        .margin({
          top: '25vp'
        })
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor($r('app.color.color_17B9C5'))
        .width('100%')
        .height('50vp')
        .opacity(
          // 0.5
          CommonUtils.checkIsNotEmptyLogin(this.accountText, this.psdText) ? 1 : 0.5
        )
        .onClick(async () => {
          if (CommonUtils.checkIsNotEmptyLogin(this.accountText, this.psdText)) {
            if (this.privacy_checkOn) {

              let map = new Map<string, string>()
              map.set("username", this.accountText)
              map.set("encryptPwd", await CommonUtils.getMd5String(this.psdText))
              map.set("clientType", "ANDROID")
              map.set("operatingSystem", deviceInfo.osFullName)
              map.set("mobileType", deviceInfo.productModel)
              map.set("mobileBrand", "HUAWEI")

              let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT

              try {
                bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
                  Logger.debug(Constants.TAG, "getBundleInfoForSelf success：" + JSON.stringify(data))

                  map.set("clientVersion", data.versionName)

                  // map.forEach((value,key)=>{
                  //   Logger.debug(Constants.TAG,"打印的map为:"+key+":"+value)
                  // })
                  getLoginPsdList(map).then((data) => {
                    switch (data.code) {
                      case Constants.SUCCESS:
                        router.replaceUrl({
                          url: 'pages/MainPage',
                        }), router.RouterMode.Standard, (err) => {
                          if (err) {
                            Logger.error(Constants.TAG, `LoginHome push to MainPage is failed,code is ${err.code},message is ${err.message}`);
                            return;
                          }
                          Logger.debug(Constants.TAG, ` LoginHome push to MainPage is success`)
                        }
                        break;
                      case Constants.FAILURE:
                        this.psdWrongController.open()
                        Logger.debug(Constants.TAG, ` LoginHome push to MainPage is failure` + JSON.stringify(data))
                        let flag = data.data.flag
                        if (flag == 2) {
                          this.count++

                        }

                        break;
                    }

                  })
                }).catch(err => {
                  Logger.info(Constants.TAG, "getBundleInfoForSelf failed. Cause: %{public}s" + err.message)
                })
              } catch (err) {
                Logger.error(Constants.TAG, "getBundleInfoForSelf failed: %{public}s" + err.message)
              }

            } else {
              this.privacyController.open()
            }
          }
        })

      Row() {
        Text('注册').fontSize('13fp').fontColor($r('app.color.color_646464'))
        Text('忘记密码').fontSize('13fp').fontColor($r('app.color.color_949494'))
      }.width('100%').margin({
        top: '15vp'
      }).justifyContent(FlexAlign.SpaceBetween)

      //隐私政策，用户协议
      Row() {
        Toggle({
          type: ToggleType.Checkbox, isOn: false
        }).selectedColor($r('app.color.color_17B9C5'))
          .onChange((isOn: boolean) => {
            this.privacy_checkOn = isOn
          }).width(12).height(12)

        Text($r('app.string.agree_privacy')).fontSize('11fp').fontColor($r('app.color.color_949494'))
        Text($r('app.string.user_agree')).fontSize('11fp').fontColor($r('app.color.color_17B9C5')).onClick(() => {
          router.pushUrl({
            url: 'pages/WebView',
            params: {
              url: 'https://www.jyjyapp.com/terms/agreement.html',
              title: $r('app.string.user_agree')
            }
          }), router.RouterMode.Standard, (err => {
            if (err) {
              Logger.error(Constants.TAG, `agree_privacy LoginHome push to Webview is failed,code is ${err.code},message is ${err.message}`);
              return;
            }
            Logger.debug(Constants.TAG, `agree_privacy LoginHome push to Webview is success`)
          });
        })
        Text($r('app.string.and')).fontSize('11fp').fontColor($r('app.color.color_949494'))
        Text($r('app.string.privacy_policy')).fontSize('11fp').fontColor($r('app.color.color_17B9C5')).onClick(() => {
          router.pushUrl({
            url: 'pages/WebView',
            params: {
              url: 'https://www.jyjyapp.com/terms/privacy.html',
              title: $r('app.string.privacy_policy')
            }
          }), router.RouterMode.Standard, (err => {
            if (err) {
              Logger.error(Constants.TAG, `privacy LoginHome push to Webview is failed,code is ${err.code},message is ${err.message}`);
              return;
            }
            Logger.debug(Constants.TAG, `privacy LoginHome push to Webview is success`)
          });
        })

      }.width('100%').margin({
        top: '10vp'
      }).justifyContent(FlexAlign.Start)

    }
    .padding({
      left: '25vp',
      right: '25vp'
    })
    .backgroundColor($r('app.color.white'))
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)

  }
}













