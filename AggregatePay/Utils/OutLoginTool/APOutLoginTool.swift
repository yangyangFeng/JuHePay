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
        
        let app: AppDelegate = APPDElEGATE
        app.window?.rootViewController = app.createTabBarController()
        let tabBarC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        let homeC = tabBarC.selectedViewController
        let loginVC = APBaseNavigationViewController(rootViewController: APLoginViewController())
        homeC?.present(loginVC, animated: true)
    }
    
    
}
