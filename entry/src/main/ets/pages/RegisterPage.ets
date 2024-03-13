@Entry
@Component
struct RegisterPage {
  @State message: string = 'Hello World'

  build() {
    Column() {
      Row() {

      }
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