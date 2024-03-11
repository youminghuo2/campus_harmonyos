@Component
export default struct TitleBuilder {
  title: string;
  targetIndex: number;
  selectedImg: Resource;
  normalImg: Resource;
  currentIndex: number;

  build() {
   Column() {
      Image(this.currentIndex === this.targetIndex ? this.selectedImg : this.normalImg)
        .size({ width: 25, height: 25 })
      Text(this.title)
        .fontColor(this.currentIndex === this.targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Center)
  }
}