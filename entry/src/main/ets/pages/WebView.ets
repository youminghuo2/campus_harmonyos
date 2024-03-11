import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import TitleBar from '../frame/ui/Titlebar';

@Entry
@Component
export default struct WebView {
  @State params: object = router.getParams()
  @State url: string = ""
  @State title: string = ""

  aboutToAppear() {
    this.url = this.params?.['url']
    this.title = this.params?.['title']
  }

  build() {
    Row() {
      Column() {
        TitleBar({
          title: this.title,
          closeClick: () => router.back()
        })

        webViewCompose({ url:$url })
      }
      .width('100%').height('100%')
    }.width('100%')
    .height('100%')
  }
}

@Component
struct webViewCompose {
  @Link url:string;

  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  build(){
    Scroll(){
      Column(){
        Web({ src:this.url, controller: this.webviewController })
      }
    }.scrollable(ScrollDirection.Vertical)
  }
}