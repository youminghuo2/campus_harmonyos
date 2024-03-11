/**
 * 启动页
 */
import dataPreferences from '@ohos.data.preferences';
import JumpUtils from '../common/JumpUtils';

import { PreferencesUtil } from '../common/PreferencesUtil';

import SpKey from '../common/SpKey';
import { Splash } from '../frame/ui/Splash';
import { SplashEntity } from '../network/entity/SplashEntity';

@Entry
@Component
export struct SplashPage {
  @State splashList: string[] = []
  @State preference: dataPreferences.Preferences = null;
  private swiperController: SwiperController = new SwiperController()

  async aboutToAppear() {
    this.splashList = await PreferencesUtil.getEntity(SpKey.splashImgList);

  }

  build() {
    Column() {
      if (this.splashList.length > 1) {
        Swiper(this.swiperController) {
          ForEach(this.splashList, (item: string, index: number) => {
            if (index == this.splashList.length - 1) {
              Stack({ alignContent: Alignment.Bottom }) {
                this.splashImage(item)
                Button('进入').margin({
                  bottom: '50vp'
                }).fontSize(16)
                  .fontColor(Color.White)
                  .backgroundColor($r('app.color.color_17B9C5'))
                  .width('100vp').onClick(()=>{
                 JumpUtils.jumpToLoginHome()
                })
              }
            } else {
              this.splashImage(item)
            }

          }, (item: string) => item)
        }.loop(false)
      } else {
        Splash({ mSplash: new SplashEntity(3, $r('app.media.splash')), dataList: $splashList })
      }
    }.width('100%')
  }

  @Builder splashImage(item: string) {
    Image(item)
      .width('100%')
      .height('100%')
  }
}


