/**
 * 只有一个确定按钮的弹窗
 */

@Extend(Text) function fontText(fontSize: number) {
  .fontSize(fontSize)
  .width('100%')
  .fontColor($r('app.color.color_ff39393b'))
  .textAlign(TextAlign.Center)
  .padding({ top: 15, bottom: 0, left: 8, right: 8 })
  .alignSelf(ItemAlign.Center)
  .margin({ top: 15 })
}


@Extend(Text) function funBtn(fontColor: Resource) {
  .fontColor(fontColor)
  .fontSize(17)
  .width('100%')
  .height('30vp')
  .textAlign(TextAlign.Center)
}

@CustomDialog
export default struct TwoBtnDialog {
  content = ''
  positiveText = '确定'
  positiveColor = $r('app.color.color_17B9C5')
  negativeText='取消'
  negativeColor=$r('app.color.color_17B9C5')
  controller: CustomDialogController
  positive: () => void
  negative:()=> void

  @Builder TipTextStyle(tip: string, fontSize: number) {
    Text(tip)
      .fontText(fontSize)
      .visibility(tip.length > 0 ? Visibility.Visible : Visibility.None)
  }

  build() {
    Column() {
      this.TipTextStyle(this.content, 17)
      Divider().strokeWidth('1vp').color($r('app.color.line_color')).margin({
        top:'15vp'
      })
      Flex({justifyContent:FlexAlign.SpaceBetween}){

        Text(this.negativeText)
          .funBtn(this.negativeColor)
          .onClick(()=>{
            this.negative()
          })

        Text(this.positiveText)
          .funBtn(this.positiveColor)
          .onClick(()=>{
            this.positive()
          })
      }
    }
  }



}

