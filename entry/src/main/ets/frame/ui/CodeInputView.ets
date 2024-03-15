@Preview
@Component
export struct CodeInputView {
  @State viewSize: number = 6
  inputResultCallback: (string) => void
  @Link codeKids: Array<string>
  @State showCaret: boolean = true
  private inputKey = "code_input"

  aboutToAppear() {
    if (this.codeKids == null) {
      this.codeKids = new Array(this.viewSize).fill('');
    }
  }

  build() {
    Stack() {
      if (this.codeKids != null) {
        Row({ space: (10) }) {
          ForEach(this.codeKids, (item: string, index: number) => {
            Text(item)
              .backgroundColor($r('app.color.line_color'))
              .height(50)
              .width(50)
              .layoutWeight(1)
              .fontSize(25)
              .textAlign(TextAlign.Center)
              .align(Alignment.Center)
              .borderRadius(15)

              .focusable(false)
              .defaultFocus(false)
              .focusOnTouch(false)
              .onClick(() => {
                focusControl.requestFocus(this.inputKey)
              })
          }, (item: string) => item)
        }
        .height('100%').width('100%')


        TextInput()
          .maxLength(this.viewSize)
          .fontSize(15)
          .borderRadius(4)
          .type(InputType.Number)
          .key(this.inputKey)
          .onChange((value) => {
            let a = value.split('')
            this.codeKids.forEach((value, index) => {
              this.codeKids[index] = a[index] || ''
            })
            if (a.length >= this.viewSize) {
              // 当达到验证码长度时，触发回调函数传递输入结果
              this.inputResultCallback(value)
            }
            // 控制光标显示/隐藏
            this.showCaret = (a.length == 0)
          })
            // 禁用复制操作
          .copyOption(CopyOptions.None)
            // 设置光标颜色
          .caretColor(this.showCaret ? Color.Black : Color.Transparent)
          .fontSize(Color.Transparent)
          .backgroundColor(Color.Transparent)
          .stateStyles({ pressed: {.backgroundColor($r('app.color.white'))
          } })
          .height('100%')
          .width('100%')
      }
    }.height(80)

  }
}