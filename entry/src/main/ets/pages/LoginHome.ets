// @ts-ignore
import CommonUtils from '../common/CommonUtils'
import Logger from '../common/Logger'



@Entry
@Component
struct LoginHome {
  @State message: string = 'Hello World'
  @State checked: string = "psd"
  @State isLogin: Boolean = false
  @State accountText: string = ""
  @State psdText: string = ""
  //当前的模式是账号密码，或者短信
  @State mode: string = "psd"

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
          CommonUtils.checkIsEmptyLogin(this.accountText, this.psdText) ? 1 : 0.5
        )

      Row() {
        Text('注册').fontSize('13fp').fontColor($r('app.color.color_646464'))
        Text('忘记密码').fontSize('13fp').fontColor($r('app.color.color_949494'))
      }.width('100%').margin({
        top: '15vp'
      }).justifyContent(FlexAlign.SpaceBetween)


      Row() {
        Toggle({
          type: ToggleType.Checkbox, isOn: false
        }).selectedColor($r('app.color.color_17B9C5'))

        Text($r('app.string.agree_privacy')).fontSize('11fp').fontColor($r('app.color.color_949494'))
        Text($r('app.string.user_agree')).fontSize('11fp').fontColor($r('app.color.color_17B9C5'))
        Text($r('app.string.and')).fontSize('11fp').fontColor($r('app.color.color_949494'))
        Text($r('app.string.privacy_policy')).fontSize('11fp').fontColor($r('app.color.color_17B9C5'))

      }.width('100%').margin({
        top: '15vp'
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





