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
        return true
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

