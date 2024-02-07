@Entry
@Component
struct LoginHome {
  @State message: string = 'Hello World'
  @State checked: string = "psd"
  @State isLogin:Boolean=false

  build() {
    Column() {
      Image($r('app.media.close')).width('18vp').height('18vp').margin({
        top:'20vp'
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
        }).margin({
          left: '30vp'
        })

      }.width('100%')
      .margin({
        top: '30vp',
      })

      Row() {
        Image(this.checked == 'psd' ? $r('app.media.account') : $r('app.media.phone')).width(20)

        TextInput({
          placeholder: this.checked == 'psd' ? $r('app.string.phone_input') : $r('app.string.sms_verity')
        }
        ).style(TextInputStyle.Inline).border({ width: 0 }).backgroundColor(Color.White)

      }.margin({
        top: '20vp',
      })

      Divider().strokeWidth('0.5vp').color($r('app.color.line_color'))

      Row() {
        Image(this.checked == 'psd' ? $r('app.media.psd') : $r('app.media.smsPsd')).width(20)

        TextInput({
          placeholder: this.checked == 'psd' ? $r('app.string.psd_input') : $r('app.string.smsPsd_input')
        }
        ).style(TextInputStyle.Inline).border({ width: 0 }).backgroundColor(Color.White).width('60%')


        Text('获取验证码')
          .visibility(this.checked == 'sms' ? Visibility.Visible : Visibility.Hidden)
          .textAlign(TextAlign.End)
          .width('30%')
          .fontSize(16)
          .fontColor($r('app.color.color_CCCCCC'))


      }.margin({
        top: '15vp',
      })

      Divider().margin({
      }).strokeWidth('0.5vp').color($r('app.color.line_color'))

      Button($r('app.string.login_at'))
        .borderRadius(8)
        .margin({
          top:'25vp'
        }).fontSize(16).fontColor(Color.White)
        .backgroundColor($r('app.color.color_17B9C5')).opacity(0.5).width('100%').height('50vp')

    }
    .padding({
      left:'25vp',
      right:'25vp'
    })
    .backgroundColor($r('app.color.white'))
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)

  }
}





