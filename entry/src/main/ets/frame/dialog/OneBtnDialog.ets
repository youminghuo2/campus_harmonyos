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
  .height('50vp')
  .textAlign(TextAlign.Center)
}

@CustomDialog
export default struct OneBtnDialog {
  content = ''
  positiveText = '确定'
  positiveColor = $r('app.color.color_17B9C5')
  controller: CustomDialogController
  positive: () => void

  @Builder TipTextStyle(tip: string, fontSize: number) {
    Text(tip)
      .fontText(fontSize)
      .visibility(tip.length > 0 ? Visibility.Visible : Visibility.None)
  }

  build() {
    Column() {
      this.TipTextStyle(this.content, 17)
      Divider().strokeWidth('1vp').color($r('app.color.line_color'))
      Flex({ justifyContent: FlexAlign.Center }) {
        Text(this.positiveText)
          .funBtn(this.positiveColor)
          .onClick(() => {
            this.controller.close()
            this.positive()
          })
      }.margin({top:20,bottom:15,left:15,right:15})
    }
  }
}

