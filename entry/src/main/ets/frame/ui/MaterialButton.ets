/*
 *通用确定按钮
 */

@Component
export default struct MaterialButton {
  text: string=''
  textColor: Resource = $r('app.color.white')
  textSize: number = 16
  radius: number = 8
  backgroundColors: Resource = $r('app.color.color_17B9C5')
  @Prop opacitys: boolean
  marginTop: number = 20
  marginLeft: number = 0
  marginRight: number = 0
  marginBottom: number = 0
  onClickListener: () => void

  build() {
    Row() {
      Button(this.text, {
        type: ButtonType.Normal
      })
        .fontColor(this.textColor)
        .fontSize(this.textSize)
        .width('100%')
        .borderRadius(this.radius)
        .backgroundColor(this.backgroundColors)
        .height(50)
        .opacity(
          this.opacitys ? 1 : 0.5)
        .margin({
          top: this.marginTop,
          left: this.marginLeft,
          right: this.marginRight,
          bottom: this.marginBottom
        })
        .onClick(() => {
          if (this.opacitys) {
            this.onClickListener()
          }
        })
    }
  }
}