/**
 * 启动页单张图片
 */
import Constants from '../../common/Constants';

import { getBylication } from '../../network/api/portalApi';

import { SplashEntity } from '../../network/entity/SplashEntity';
import { PreferencesUtil } from '../../common/PreferencesUtil';
import SpKey from '../../common/SpKey';
import JumpUtils from '../../common/JumpUtils';

@Component
export struct Splash {
  @State mSplash: SplashEntity = new SplashEntity(3);

  @Link dataList :string[]


  aboutToAppear() {
    let map = new Map<string, string>();
    map.set("location",  Constants.APP_SPLASHSCREEN)
    getBylication(map).then((data) => {
      switch (data.code) {
        case Constants.SUCCESS:
          JSON.parse(JSON.stringify(data.data))
          let object = JSON.parse(JSON.stringify(data.data))
          let splashImgList: string[] = []
          for (let item of object) {
            splashImgList.push(item.pictureUrl)
          }
          PreferencesUtil.put(SpKey.splashImgList, JSON.stringify(splashImgList))
          break;
        case Constants.FAILURE:
          break;
      }
    })

     let skipWait = setInterval(() => {
      this.mSplash.timer--;
      if (this.mSplash.timer === 0) {
        clearInterval(skipWait);
        if (this.dataList.length<2) {
          JumpUtils.jumpToLoginHome()
        }
      }
    }, 1000)

  }


  build() {
    if (this.dataList.length==0 || this.dataList.length == 1) {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image(this.dataList.length==0 ? $r('app.media.splash') : this.dataList[0])
          .width('100%')
          .height('100%')

        Button(`跳过 ${this.mSplash.timer} 秒`, { type: ButtonType.Capsule })
          .backgroundColor($r('app.color.color_4D000000'))
          .height(30)
          .margin(10)
          .fontSize(12)
          .fontColor(Color.White)
          .onClick(() => {
            JumpUtils.jumpToLoginHome()
          })
      }.width('100%').height('100%')

    }
  }
}