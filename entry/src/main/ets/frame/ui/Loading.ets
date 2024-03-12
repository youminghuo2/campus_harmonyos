@Component
@Entry
export default struct Loading {
  enable: boolean = true

  build() {
    Column() {
      LoadingProgress()
        .color($r('app.color.color_17B9C5')).width('30%').enabled(this.enable)
    }.width('100%').justifyContent(FlexAlign.Center)
  }

}


