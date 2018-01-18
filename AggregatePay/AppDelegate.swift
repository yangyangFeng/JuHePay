//
//  AppDelegate.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/4.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    public var window: UIWindow?
    public var isLandscape = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ap_appDelegateConfig(launchOptions)
        
        let tabBarController = createTabBarController()
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        APGuideView.showGuideView()
        self.perform(#selector(versionUpdate),
                     with: nil,
                     afterDelay: 1)
        return true
    }
}

//MARK: ----- AppDelegate---Extension(版本升级)

extension AppDelegate {
    
    @objc func versionUpdate() {
        AppDelegate.ap_versionUpdate(window: window!)
    }
    
    static func ap_versionUpdate(window: UIWindow) {
        let request = APCheckAppVerisonRequest()
        request.systemType = "1"
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.updateApp, params: request, aClass: APCheckAppVerisonResponse.self, success: { baseResp in
            let resp = baseResp as! APCheckAppVerisonResponse
            APVersionUpgradeController.show(minVersion: resp.minVersionNo,
                                            maxVersion: resp.lastVersionNo,
                                            content: resp.lastVersionContent,
                                            storeUrl: resp.lastVersionDownloadUrl)
        }, failure: { baseError in
            print(baseError.message as Any)
        })
    }
}

//MARK: ----- AppDelegate---Extension(代理方法)

extension AppDelegate {
    
    func application(_ application: UIApplication,
                     handleOpen url: URL) -> Bool {
        return APSharedUtil.ap_open(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
        return APSharedUtil.ap_open(url)
    }
    
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if isLandscape {
            return .all
        }
        else {
            return .portrait
        }
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let url = URL.init(string: "com.cnepay.zhonghuizhifu://") {
            if UIApplication.shared.canOpenURL(url) {
              return UIApplication.shared.openURL(url)
            }
        }
        return false
    }
}

extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let notification = Notification(name: NOTIFICA_ENTER_BACKGROUND_KEY, object: nil, userInfo: nil)
        NotificationCenter.default.post(notification)
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

