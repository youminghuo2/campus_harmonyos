import router from '@ohos.router'
@Component
export default struct TitleBar{
   title:string=''
  closeIsVisible:boolean=false
  closeClick: () => void

  build(){
    Row(){
      Image($r('app.media.titlebar_back')).width('20vp').height('20vp').onClick(()=>{
          router.back()
      })


      Text(this.title).fontSize(17).fontColor($r('app.color.white'))

      Image($r('app.media.titlebar_close')).width('20vp').height('20vp').onClick(()=>{
         this.closeClick()
      }).visibility(this.closeIsVisible? Visibility.Visible : Visibility.Hidden)
    }.width('100%').height('50vp').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).backgroundColor($r('app.color.color_17B9C5')).padding({
      left:'15vp',
      right:'15vp',
    })
  }
}