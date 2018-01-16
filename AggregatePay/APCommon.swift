

let AP_TableViewBackgroundColor = "#F5F5F5"

let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
/// 获取AppDelegate
let APPDElEGATE = UIApplication.shared.delegate as! AppDelegate

/// 获取屏幕宽和高
let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height


//程序退出后台通知
let NOTIFICA_ENTER_BACKGROUND_KEY = NSNotification.Name(rawValue: "NOTIFICA_ENTER_BACKGROUND")
//选择商户大类通知
let NOTIFICA_SELECT_MERCHANT_KEY  = NSNotification.Name(rawValue: "NOTIFICA_SELECT_MERCHANT_KEY")



/*************************AES秘钥**************************/
let AP_AES_Key = "q+21NWcZFQLG0WuM"
/*************************极光推送Key**************************/
let AP_JPush_Key = "c28b33d238c98a7a0527e6a3"
/*************************微信分享Key**************************/
let AP_WECHAT_KEY = "wx112291ad060761a0"

