//
//  APBaseViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import SwiftTheme

class APBaseViewController: UIViewController {
    
    deinit {
        print( String(describing: self.classForCoder) + "已释放")
    }
    
    private var isStatusBarHidden: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        /*view四周均不延伸*/
        edgesForExtendedLayout = []
        
        view.backgroundColor = UIColor.init(hex6: 0xf0f0f0)

        ap_setStatusBarStyle(UIStatusBarStyle.default)
        
        initNavigationBar()
        
        initNavigationItem()

    }
    
    func initNavigationItem()
    {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        
        guard self.navigationController?.viewControllers.count == 1 else {
            let leftButton = UIBarButtonItem(image: AP_navigationLeftItemImage(), style: UIBarButtonItemStyle.done, target: self, action: #selector(goBackAction))
            navigationItem.leftBarButtonItem = leftButton
            return
        }
        navigationItem.leftBarButtonItem = nil
        
        //        let titleAttributes = APGlobalPicker.barTextColors.map { (hexString) in
        //            return [
        //                NSAttributedStringKey.foregroundColor: UIColor(rgba: hexString),
        //                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18),
        //                ]
        //        }
        //
        //        self.navigationController?.navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithAttributes(titleAttributes)
    }
    
    func initNavigationBar()
    {
        self.vhl_setNavBarShadowImageHidden(true)
        
        self.vhl_setNavBarTintColor(UIColor(hex6: 0xc8a556))
        
        self.vhl_setNavBackgroundColor(UIColor.init(hex6: 0x373737))
        
        self.vhl_setNavBarTitleColor(UIColor(hex6: 0xc8a556))
    }
    
    func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "Navigation_Back")

        return image!.withRenderingMode(.alwaysTemplate)
    }
    
    
    
    @objc func goBackAction()
    {
        navigationController?.popViewController()
    }
    
    
    /// 设置当前控制器状态栏style
    ///
    /// - Parameter style:
    func ap_setStatusBarStyle(_ style : UIStatusBarStyle)
    {
        self.vhl_setStatusBarStyle(style)
    }
    
    /// 设置当前导航栏 title 颜色
    ///
    /// - Parameter color:
    func ap_setTitleColor(_ color : UIColor) {
        self.vhl_setNavBarTitleColor(color)
//        let titleAttributes = APGlobalPicker.barTextColors.map { (hexString) in
//            return [
//                NSAttributedStringKey.foregroundColor: UIColor(rgba: hexString),
//                ]
//        }
//        self.navigationController?.navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithAttributes(titleAttributes)
    }
    
    /// 设置当前控制器导航栏背景色
    ///
    /// - Parameter color:
    func ap_setNavigationBarBackGroundColor(_ color : UIColor) {
        self.vhl_setNavBackgroundColor(color)
    }

    /// 设置当前控制器导航栏是否隐藏
    ///
    /// - Parameter hidden:
    func ap_setNavigationBarHidden(_ hidden : Bool){
        self.vhl_setNavBarHidden(hidden)
    }
}

extension APBaseViewController {
    
    /// statusBar隐藏有一个过渡动画
    ///
    /// - Parameter isHidden: 是否隐藏
    public func ap_statusBarHidden(isHidden: Bool) {
        isStatusBarHidden = isHidden
        UIView.animate(withDuration: 0.28) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

//MARK: ------ APBaseViewController - Extension(用户身份验证)



extension APBaseViewController {
    
    //用户权限状态
    enum APUserAuthStatus: Int {
        case success    = 1  //审核成
    }
    
    typealias APUserAuthStatusBlock = (_ param: APUserAuthStatus) -> Void
    
    func ap_userIdentityStatus(authStatusCallBack: APUserAuthStatusBlock) {
        if !APUserInfoTool.isLogin {
            ap_presentLoginVC()
        }
        else {
//            ap_pushAuthVC(alertMsg: "您还未进行身份证认证，请先进行认证。")
            authStatusCallBack(success)
        }
    }
    
    //模态跳转登录页面
    private func ap_presentLoginVC() {
        let loginVC = APBaseNavigationViewController(rootViewController: APLoginViewController())
        self.present(loginVC, animated: true)
        
    }
    
    //导航跳转四审状态
    private func ap_pushAuthVC(alertMsg: String) {
        weak var weakSelf = self
        APAlertManager.show(param: { (param) in
            param.apMessage = alertMsg
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let random = arc4random() % UInt32(10) + UInt32(0)
            if random % 2 == 0 {
                let authVC = APAuthHomeViewController()
                weakSelf?.navigationController?.pushViewController(authVC, animated: true)
            }
            else {
                let authNavi = APAuthNaviViewController(rootViewController: APRealNameAuthViewController())
                authNavi.finishAuths = {
                    weakSelf?.navigationController?.dismiss(animated: true, completion: nil)
                }
                weakSelf?.navigationController?.present(authNavi, animated: true, completion: nil)
            }
        }) { (cancelAction) in
            
        }
    }

}

