import router from '@ohos.router';
import { CodeInputView } from '../frame/ui/CodeInputView';
import TitleBar from '../frame/ui/Titlebar'
import Toast from '../frame/ui/Toast';

@Entry
@Component
struct RegisterSmsPage {

  @State number: string =''

  @State codeKids: Array<string> = new Array(6).fill('')

  onPageShow(){
    const params = router.getParams()
    this.number=params['phone']
  }

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
          Span('请输入已发送至 ').fontColor($r('app.color.color_949494')).fontSize(13)
          Span('+'+this.number)
            .fontColor($r('app.color.color_949494'))
            .fontSize(13)
          Span('的6位验证码，有效期10分钟。如未收到，请尝试重新获取验证码。')
        }.margin({ top: 20 })

        CodeInputView({
          viewSize:6,
          codeKids:$codeKids,
          inputResultCallback:(code)=>{
            Toast.makeText("可以开始调用接口了")
          }
        })


      }.padding(15).alignItems(HorizontalAlign.Start)
    }
    .backgroundColor($r('app.color.white'))
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
}