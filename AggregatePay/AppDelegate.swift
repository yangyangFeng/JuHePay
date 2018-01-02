//
//  AppDelegate.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/4.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import SnapKit
import IQKeyboardManagerSwift
import ESTabBarController_swift
import SwiftTheme
import Toast_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    public var window: UIWindow?
    public var isLandscape = false
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        /**********************键盘管理*************************/
        attributeIQKeyboardManager()
        /**********************登录超时监听*************************/
        registerNeedLoginNotification()
        
        /**********************主题配置*************************/
        APP_Theme.switchThemeTo(theme: APP_Theme.Normal)
        
        /**********************Toast配置*************************/
        ToastManager.shared.duration = 1.5
        ToastManager.shared.position = .center
        
        /**********************微信分享配置*************************/
        APSharedTools.sharedInstance.register(key: "")
        
        /**********************JPush配置*************************/
        registerJPush(launchOptions: launchOptions)
        
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
   
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = APBaseTabBarViewController()
        ThemeManager.setTheme(index: 0)
        tabBarController.delegate = self
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.theme_barTintColor = ["#373737","#213"]
        tabBarController.tabBar.theme_tintColor = ["#373737","#213"]
        
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            if index == 1 {
                tabbarController.selectedIndex = 2
                let homeController : UINavigationController = tabbarController.viewControllers![2] as! UINavigationController
                homeController.pushViewController(APPromoteViewController())
            }
        }
        let wallet = APBaseNavigationViewController(rootViewController: APWalletViewController())
        let promote = APBaseNavigationViewController(rootViewController: APPromoteViewController())
        let home = APBaseNavigationViewController(rootViewController: APHomeViewController())
        let earnings = APBaseNavigationViewController(rootViewController: APEarningsViewController())
        let mine = APBaseNavigationViewController(rootViewController: APMineViewController())

        wallet.tabBarItem = ESTabBarItem.init(APTabBarItemContentView(),
                                            title: "Home",
                                            image: UIImage(named: "Home_TbaBar_钱包_N"),
                                            selectedImage: UIImage(named: "Home_TbaBar_钱包_H"))
        promote.tabBarItem = ESTabBarItem.init(APTabBarItemContentView(),
                                             title: "Find",
                                             image: UIImage(named: "Home_TbaBar_推广_N"),
                                             selectedImage: UIImage(named: "Home_TbaBar_推广_H"))
        home.tabBarItem = ESTabBarItem.init(APIrregularityContentView(),
                                             title: nil,
                                             image: UIImage(named: "Home_TbaBar_收款_N"),
                                             selectedImage: UIImage(named: "Home_TbaBar_收款_H"))
        earnings.tabBarItem = ESTabBarItem.init(APTabBarItemContentView(),
                                             title: "Favor",
                                             image: UIImage(named: "Home_TbaBar_收益_N"),
                                             selectedImage: UIImage(named: "Home_TbaBar_收益_H"))
        mine.tabBarItem = ESTabBarItem.init(APTabBarItemContentView(),
                                             title: "Me",
                                             image: UIImage(named: "Home_TbaBar_我的_N"),
                                             selectedImage: UIImage(named: "Home_TbaBar_我的_H"))

        tabBarController.tabBar.shadowImage = nil
        tabBarController.viewControllers = [wallet,promote,home,earnings,mine]
        tabBarController.selectedIndex = 2
        return tabBarController
    }
}

extension AppDelegate {
    
    func attributeIQKeyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        //控制点击背景是否收起键盘
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        //控制键盘上的工具条文字颜色是否用户自定义
        IQKeyboardManager.sharedManager().shouldShowToolbarPlaceholder = true
        //将右边Done改成完成
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "完成"
        // 控制是否显示键盘上的工具条
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        //最新版的设置键盘的returnKey的关键字 ,
        //可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘
        IQKeyboardManager.sharedManager().toolbarManageBehaviour = .byPosition
    }
    
    func registerNeedLoginNotification() {

        NotificationCenter.default.addObserver(self, selector: #selector(notificationNeedLogin(_:)), name: NSNotification.Name(rawValue: "NEED_LOGIN"), object: nil)
    }
    
    @objc func notificationNeedLogin(_ notif: Notification) {
        APAlertManager.show(param: { (param) in
            param.apMessage = "登录信息过期。"
            param.apConfirmTitle = "确定"
        }, confirm: { (confirmAction) in
            APOutLoginTool.loginOut()
        })
    }
    
}



extension AppDelegate {
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return APSharedTools.sharedInstance.openURl(url: url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return APSharedTools.sharedInstance.openURl(url: url)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if isLandscape {
            return .all
        } else {
            return .portrait
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let url = URL.init(string: "com.cnepay.zhonghuizhifu://") {
            if UIApplication.shared.canOpenURL(url) {
              return UIApplication.shared.openURL(url)
            }
        }
        return false
    }
}




@available(iOS 10.0, *)
extension AppDelegate:JPUSHRegisterDelegate {
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
}

extension AppDelegate {
    
    func registerJPush(launchOptions:[UIApplicationLaunchOptionsKey:Any]?) {

        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue |
                            JPAuthorizationOptions.badge.rawValue |
                            JPAuthorizationOptions.sound.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate:self as JPUSHRegisterDelegate)

        JPUSHService.setup(withOption: launchOptions, appKey: "51fcb1d24866e95c8fbea204", channel: "", apsForProduction: false)
        //        JPUSHService.setLogOFF() //关闭日志打印
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    // 前台模式收到推送数据
    func application(_ application:UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable:Any], fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) ->Void) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        
        completionHandler(.newData)
    }
    
    func application(_ application:UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable:Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
    }
}







extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        JPUSHService.resetBadge()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

