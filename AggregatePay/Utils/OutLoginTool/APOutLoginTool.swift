//
//  APOutLoginTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APOutLoginTool: NSObject {
    
    static func loginOut() {
        emptyData()
        let app: AppDelegate = APPDElEGATE
        let rootVC = app.window?.rootViewController
        rootVC?.childViewControllers.last?.dismiss(animated: false, completion: nil)
        app.window?.rootViewController = app.createTabBarController()
        let tabBarC = app.window?.rootViewController as! APBaseTabBarViewController
        let homeC = tabBarC.selectedViewController
        homeC?.present(APBaseNavigationViewController(rootViewController: APLoginViewController()), animated: true)
    }

    static func login() {
        emptyData()
        let app: AppDelegate = APPDElEGATE
        let rootVC = app.window?.rootViewController
        rootVC?.present(APBaseNavigationViewController(rootViewController: APLoginViewController()), animated: true)
    }
    
    static func emptyData() {
    
        APUserDefaultCache.AP_remove(key: .userInfo)
        APUserDefaultCache.AP_remove(key: .password)
        APUserDefaultCache.AP_remove(key: .cookie)
        APUserDefaultCache.AP_remove(key: .userId)
    }
}
