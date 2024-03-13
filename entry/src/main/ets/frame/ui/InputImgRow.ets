/**
 * 登录，注册等带图片的TextInput
 */
@Component
export default struct InputImgRow {
  image: Resource;
  placeholder: Resource;
  text: string;
  inputType: InputType;
  onChange: (value: string) => void;
  marginTop: number = 15


  build() {
    Column(){
      Row() {
        Image(this.image).width(20)

        TextInput({
          placeholder: this.placeholder,
          text: this.text
        })
          .style(TextInputStyle.Inline)
          .border({ width: 0 })
          .backgroundColor(Color.White)
          .type(this.inputType)
          .onChange((value: string) => {
            this.onChange(value)
          })
          .onChange(this.onChange)
      }.width('100%').margin({ top: this.marginTop })

      Divider().strokeWidth('1vp').color($r('app.color.line_color'))
    }

  }
}