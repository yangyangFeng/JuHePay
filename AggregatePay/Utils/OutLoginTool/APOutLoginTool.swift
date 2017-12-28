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
        let rootVC = APPDElEGATE.window?.rootViewController
        self.perform(#selector(APOutLoginTool.pushOutLogin), with: nil, afterDelay: 0.15)
        rootVC?.childViewControllers.last?.dismiss(animated: false, completion: nil)
    }
    
    @objc static func pushOutLogin() {
        let app: AppDelegate = APPDElEGATE
        app.window?.rootViewController = app.createTabBarController()
        let tabBarC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        let homeC = tabBarC.selectedViewController
        emptyData()
        homeC?.present(APBaseNavigationViewController(rootViewController: APLoginViewController()), animated: true)
        let lastView: UIView = (app.window?.subviews.last!)!
        lastView.isUserInteractionEnabled = true
    }
    
    static func emptyData() {
        APUserDefaultCache.AP_remove(key: .password)
        APUserDefaultCache.AP_remove(key: .userId)
    }
}
