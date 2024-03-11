/**
 * 启动页
 */
import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';
import { PreferencesUtil } from '../common/PreferencesUtil';

import SpKey from '../common/SpKey';
import { Splash } from '../frame/ui/Splash';
import { SplashEntity } from '../network/entity/SplashEntity';
import Constants from '../common/Constants';


@Entry
@Component
export  struct  SplashPage{
  @State splashList :string[]=[]
  @State preference: dataPreferences.Preferences = null;

  async getPreference() {
    try {
      // 异步转同步使用
      this.preference = await PreferencesUtil.getPreferences()
      console.info(Constants.TAG, `订阅首选项变化`);
      this.preference.on('change',(data) => {
        console.info(Constants.TAG, `订阅 key : ${JSON.stringify(data)}`);
      })
    } catch (e) {
      console.info(Constants.TAG, `Failed : ${JSON.stringify(e)}`);
    }
  }

  aboutToAppear() {
    PreferencesUtil.getEntity(SpKey.splashImgList).then((value:string[])=>{
      this.splashList=value
    })
    this.getPreference()
  }

    build(){
    Column(){
      if (this.splashList.length>1){

      }else {
        Splash({mSplash:new SplashEntity(3,$r('app.media.splash')),dataList:$splashList})
      }
    }.width('100%')
  }


}