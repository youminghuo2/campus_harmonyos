import promptAction from '@ohos.promptAction'

/**
 * 此处统一调用Toast是因为Toast被键盘遮住bug，目前官方尚未修复
 * 给出的答复，bottom设置为400，后续方便统一修改
 */

class Toast{

  makeText(msg:string):void{
    promptAction.showToast({message:msg,bottom:400})
  }
}
export default new Toast()