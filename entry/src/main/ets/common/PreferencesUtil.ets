import dataPreferences from '@ohos.data.preferences';
import Constants from './Constants';
import GlobalContext from './GlobalContext';
import Logger from './Logger';

let preference: dataPreferences.Preferences;
let preferenceTemp: dataPreferences.Preferences;
let context = getContext(this);

/**
 * SharePreference存储封装类
 */
export class PreferencesUtil {

  /**
   * 全局获取
   */
  public static async getPreferences(): Promise<dataPreferences.Preferences> {
    return await GlobalContext.getContext().getObject(Constants.KEY_PREFERENCES) as dataPreferences.Preferences
  }

  /**
   * 根据上下文获取
   */
  public static getPreferencesOther(context: Context): Promise<dataPreferences.Preferences> {
    return new Promise<dataPreferences.Preferences>((resolved, rejected) => {
      dataPreferences.getPreferences(context, Constants.KEY_PREFERENCES)
        .then((res) => {
          resolved(res);
        })
        .catch(reason => {
          rejected(`${reason}`);
        })
    });
  }


  //创建preferences
  public static async createPreferences(context: Context) {
    try {
      preference = await dataPreferences.getPreferences(context, Constants.PREFERENCES_NAME)
      GlobalContext.getContext().setObject(Constants.KEY_PREFERENCES, preference)
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to get preferences,Cause:${err}`)
    }
  }

  //删除preferences
  public static async deletePreferences() {
    try {
      await dataPreferences.deletePreferences(context, Constants.PREFERENCES_NAME)
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to delete preferences,Cause:${err}`)
    }
    preference = preferenceTemp;
  }

  //保存preferences
  public static async put(key: string, value: unknown) {
    if (!preference) {
      await this.createPreferences(getContext(this))
    }
    try {
      if (typeof value == "number") {
        await preference.put(key, value)
      }
      if (typeof value == "string") {
        await preference.put(key, value)
      }
      if (typeof value == "boolean") {
        await preference.put(key, value)
      }
      if (typeof value == "object") {
        if (Array.isArray(value)) {
          await preference.put(key,value)
        }else {
        await preference.put(key,JSON.stringify(value))
        }
    }
    }
    catch(err) {
      Logger.error(Constants.TAG, `Failed to put value,Cause:${err}`)
    }
     await preference.flush()
  }

  /**
   * 获取preference
   */
  public static async get(key: string) {
    let value: null;
    if (!preference) {
      await this.createPreferences(getContext(this));
    }
    try {
      value = await preference.get(key, undefined).then();
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to get value, Cause: ${err}`);
    }
    return value;
  }


  /**
   * 获取自定义实体数据。
   */
  public static async getEntity(key:string){
    let value:string=""
    if (!preference) {
      await this.createPreferences(getContext(this))
    }
    try {
      value=(await preference.get(key,'')).toString()
    }catch (err){
      Logger.error(Constants.TAG,`Failed to get value,Cause:${err}`)
    }
    let obj
    try {
      obj = JSON.parse(value);
      console.log(obj);
    } catch (err) {
      console.log('Value is not a valid JSON string:', err);
    }
    return obj
  }

  /**
   * 获取包含所有键值的Object对象
   */
  public static async getAll(){
    let value:unknown
    if (!preference) {
      await this.createPreferences(getContext(this))
    }
    try {
      value = await preference.getAll().then()
    }catch (err){
      Logger.error(Constants.TAG, `Failed to get value, Cause: ${err}`)
    }
    return value
  }

  /**
   * 检查 Preferences 实例是否包含名为给定 Key 的存储键值对
   */
  public static async has(key:string){
    let  value:boolean=false
    if (!preference) {
      await this.createPreferences(getContext(this))
    }
     try {
      value = await preference.has(key).then();
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to get value, Cause: ${err}`);
    }
    return value;
  }

  /**
   * 从 Preferences 实例中删除名为给定 Key 的存储键值对
   */
  public static async delete(key: string) {
    if (!preference) {
      await this.createPreferences(getContext(this));
    }
    try {
      await preference.delete(key).then();
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to get value, Cause: ${err}`);
    }
  }

  /**
   * 清除此 Preferences 实例中的所有存储
   */
  public static async clear() {
    if (!preference) {
      await this.createPreferences(getContext(this));
    }
    try {
      await preference.clear().then();
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to get value, Cause: ${err}`);
    }
  }

  /**
   * 将数据从当前 Preferences 实例异步存储到用户首选项的持久文件中
   */
  public static async flush() {
    if (!preference) {
      await this.createPreferences(getContext(this));
    }
    try {
      await preference.flush().then();
    } catch (err) {
      Logger.error(Constants.TAG, `Failed to get value, Cause: ${err}`);
    }
  }
}
