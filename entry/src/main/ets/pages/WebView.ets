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
      Column() {
        TitleBar({
          title: this.title,
          closeClick: () => router.back()
        })

        webViewCompose({ url:$url })
      }
      .width('100%')
  }
}

@Component
struct webViewCompose {
  @Link url:string;

  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  build(){
      Column(){
        Web({ src:this.url, controller: this.webviewController }).height('100%').width('100%')
      }
  }
}