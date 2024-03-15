
import CommonUtils from '../common/CommonUtils'
import Constants from '../common/Constants'
import JumpUtils from '../common/JumpUtils'
import Logger from '../common/Logger'
import InputImgRow from '../frame/ui/InputImgRow'
import MaterialButton from '../frame/ui/MaterialButton'
import TitleBar from '../frame/ui/Titlebar'
import Toast from '../frame/ui/Toast'
import { registerSmsCode } from '../network/api/basicdataApi'

@Entry
@Component
struct RegisterPage {
  @State phoneText: string = ""
  @State nameText: string = ""
  @State psdText: string = ""
  @State privacy_checkOn: boolean = false

  build() {
    Column() {
      TitleBar({
        title: '家长账号注册',
        titleColor: $r('app.color.color_353535'),
        backImageUrl: $r('app.media.titlebar_back_black'),
        backgroundColors: $r('app.color.white'),
      }).width('100%')

      Column() {
        Text('完善信息').fontSize(27)

        Text() {
          Span('本页面用于家长注册，教师账号由学校设置。').fontColor($r('app.color.color_ff4d4f')).fontSize(13)
          Span('手机号码用于登录和重置密码；密码8-20位，需包含大写字母、小写字母、数字或特殊字符至少三种组合。')
            .fontColor($r('app.color.color_949494'))
            .fontSize(13)
        }.margin({ top: 20 })


        //手机号码
        InputImgRow({
          image:$r('app.media.phone'),
          placeholder: $r('app.string.phone_input'),
          text:this.phoneText,
          inputType:InputType.PhoneNumber,
          onChange:(value:string)=>{
            this.phoneText=value
          }
        })

        //真实姓名
        InputImgRow({
          image:$r('app.media.account'),
          placeholder: $r('app.string.name_input'),
          text:this.nameText,
          inputType:InputType.Normal,
          onChange:(value:string)=>{
            this.nameText=value
          }
        })

        //密码
        InputImgRow({
          image:$r('app.media.psd'),
          placeholder: $r('app.string.psd_input'),
          text:this.psdText,
          inputType:InputType.Normal,
          onChange:(value:string)=>{
            this.psdText = value
          }
        })

        MaterialButton({
          text:'下一步',
          opacitys:!CommonUtils.checkIsEmpty(this.phoneText) &&  !CommonUtils.checkIsEmpty(this.phoneText) && !CommonUtils.checkIsEmpty(this.psdText),
          onClickListener:()=>{
            if (this.privacy_checkOn) {
              if (CommonUtils.checkIsPhone(this.phoneText)){
                let map = new Map<string, string>()
                map.set("mobile",this.phoneText)
                registerSmsCode(map).then((data)=>{
                  this.registerDataResult(data)
                  Logger.debug(Constants.TAG, "registerSmsCode：" + JSON.stringify(data))
                })
              }else{
               Toast.makeText('手机号码不正确')
              }
            }else{
              Toast.makeText('注册前请先阅读并同意相关协议')
            }
          }
        })

        //隐私政策，用户协议
        Row() {
          Toggle({
            type: ToggleType.Checkbox, isOn: false
          }).selectedColor($r('app.color.color_17B9C5'))
            .onChange((isOn: boolean) => {
              this.privacy_checkOn = isOn
            }).width(12).height(12)

          Text($r('app.string.agree_privacy')).fontSize(11).fontColor($r('app.color.color_949494'))
          Text($r('app.string.user_agree')).fontSize(11).fontColor($r('app.color.color_17B9C5')).onClick(() => {
            JumpUtils.JumpToWebView('https://www.jyjyapp.com/terms/agreement.html', $r('app.string.user_agree'))
          })
          Text($r('app.string.and')).fontSize('11fp').fontColor($r('app.color.color_949494'))
          Text($r('app.string.privacy_policy')).fontSize(11).fontColor($r('app.color.color_17B9C5')).onClick(() => {
            JumpUtils.JumpToWebView('https://www.jyjyapp.com/terms/privacy.html', $r('app.string.privacy_policy'))
          })

        }.width('100%').margin({
          top: '10vp'
        }).justifyContent(FlexAlign.Start)

      }.padding(15).alignItems(HorizontalAlign.Start)
    }
    .backgroundColor($r('app.color.white'))
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }

  /**
   *下一步调用接口
   * 0 -> 该手机号码已存在，请直接登录
   * else -> msg
   */
  registerDataResult(data: any) {
    switch (data.code) {
      case Constants.SUCCESS:
        JumpUtils.JumpToRegisterSmsPage(this.phoneText)
        break;
      case Constants.FAILURE:
        let flag = data.data.flag
        if (flag==0) {
          Toast.makeText('该手机号码已存在，请直接登录')
        }else{
          Toast.makeText(data.msg)
        }
        break;
    }

  }


}



