import bundleManager from '@ohos.bundle.bundleManager'
import CommonUtils from '../common/CommonUtils'

import Constants from '../common/Constants'
import Logger from '../common/Logger'
import { getLoginInfo } from '../network/api/basicdataApi'

import { getAppmodule } from '../network/api/portalApi'
@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'

   aboutToAppear(){
     getUserInfo()

   }

  build() {
       // Column(){
       //   TabContent(){
       //     Column(){
       //
       //     }.width('100%')
       //     .height('100%')
       //     .backgroundColor('#007DFF')
       //   }.tabBar(TitleBuilder('首页',0,))
       // }
  }


}



async function getUserInfo(){
  let  header= await CommonUtils.getTokenOrSchoolId()
  getLoginInfo(header).then((response)=>{
    if (response.code==Constants.SUCCESS) {
      Logger.debug(Constants.TAG, "getUserInfo：" + JSON.stringify(response))

    }
  })

}


function getAppModule(){
  let map = new Map<string, string>()
  map.set("clientType", "ANDROID")

  let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT

  try {
    bundleManager.getBundleInfoForSelf(bundleFlags).then(async (data) => {
      Logger.debug(Constants.TAG, "getBundleInfoForSelf success：" + JSON.stringify(data))
      map.set("currentClientVersion", data.versionName)

      let header= CommonUtils.getTokenOrSchoolId()

      getAppmodule(map,header).then((response) => {
        switch (response.code) {
          case Constants.SUCCESS:

            break;
          case Constants.FAILURE:

            break;
        }

      })
    }).catch(err => {
      Logger.info(Constants.TAG, "getBundleInfoForSelf failed. Cause: %{public}s" + err.message)
    })
  } catch (err) {
    Logger.error(Constants.TAG, "getBundleInfoForSelf failed: %{public}s" + err.message)
  }
}