import router from '@ohos.router'

/**
 *通用标题栏
 */

@Component
export default struct TitleBar {
  title: string = ''
  titleColor: Resource = $r('app.color.white')
  backImageUrl: Resource = $r('app.media.titlebar_back')
  backgroundColors: Resource = $r('app.color.color_17B9C5')
  closeIsVisible: boolean = false
  closeClick: () => void

  build() {
    Row() {
      Image(this.backImageUrl).width('20vp').height('20vp').onClick(() => {
        router.back()
      })

      Text(this.title).fontSize(17).fontColor(this.titleColor)

      Image($r('app.media.titlebar_close')).width('20vp').height('20vp').onClick(() => {
        this.closeClick()
      }).visibility(this.closeIsVisible ? Visibility.Visible : Visibility.Hidden)
    }
    .width('100%')
    .height('50vp')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.backgroundColors)
    .padding({
      left: '15vp',
      right: '15vp',
    })
  }
}