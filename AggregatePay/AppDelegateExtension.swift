//
//  AppDelegateExtension.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import Foundation
import SwiftTheme
import Toast_Swift
import IQKeyboardManagerSwift
import ESTabBarController_swift

extension AppDelegate {
    
   
    public func createTabBarController() -> UITabBarController {
        
        let tabBarController = APBaseTabBarViewController()
        ThemeManager.setTheme(index: 0)
        tabBarController.delegate = self
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.theme_barTintColor = ["#373737","#213"]
        tabBarController.tabBar.theme_tintColor = ["#373737","#213"]
        
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
        tabBarController.tabBarController?.selectedIndex = 2
        tabBarController.viewControllers = [wallet,promote,home,earnings,mine]
        tabBarController.selectedIndex = 2
        return tabBarController
    }
    
    public func selectTabBarIndex(atIndex: Int) -> APBaseViewController {
        let rootVC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        rootVC.selectedIndex = atIndex
        let selectNav = rootVC.selectedViewController as! APBaseNavigationViewController
        let selectVC = selectNav.childViewControllers.first as! APBaseViewController
        return selectVC
    }
    
    public func registerNeedLoginNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationNeedLogin(_:)), name: NSNotification.Name(rawValue: "NEED_LOGIN"), object: nil)
    }
    
}

//MARK: ----- AppDelegate---Extension

extension AppDelegate {
    

    func ap_appDelegateConfig() {
        
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
    }
    
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
    
   
    @objc func notificationNeedLogin(_ notif: Notification) {
        
        APAlertManager.show(param: { (param) in
            param.apMessage = "登录信息过期。"
            param.apConfirmTitle = "确定"
        }, confirm: { (confirmAction) in
            APOutLoginTool.loginOut()
        })
    }
    
}

