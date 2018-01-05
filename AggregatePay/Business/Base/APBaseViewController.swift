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
    
    func ap_userIdentityStatus(closure: @escaping () -> Void) {

        if !APUserInfoTool.isLogin() {
            APOutLoginTool.loginOut()
        }
        else {
            let isNotAuthInfo = true
            if isNotAuthInfo {
                //13621223933
                closure()
                return
            }
            let lastView: UIView = (APPDElEGATE.window?.subviews.last!)!
            lastView.AP_loadingBegin()
            let baseRequest = APBaseRequest()
            baseRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
            APAuthHttpTool.getUserAuthInfo(httpUrl: APHttpUrl.trans_httpUrl, params: baseRequest, success: { (info) in
                lastView.AP_loadingEnd()
                if self.ap_userAuthStatus(info: info) {
                    closure()
                }
            }, failure: {(baseError) in
                lastView.AP_loadingEnd()
                lastView.makeToast(baseError.message)
            })
        }
    }
    
    private func ap_userAuthStatus(info: APUserAuthInfo) -> Bool {
        let auths = APAuthHelper.sharedInstance.auths
        let authRealName: APAuth = auths[0]
        let authSettleCard: APAuth = auths[1]
        let authSecurity: APAuth = auths[2]
        
        if authRealName.state == APAuthState.Success &&
            authSettleCard.state == APAuthState.Success &&
            authSecurity.state == APAuthState.Success  {
            return true
        }
        else if authRealName.state == APAuthState.None &&
            authSettleCard.state == APAuthState.None &&
            authSecurity.state == APAuthState.None  {
            ap_pushAuthVC_frist_None()
            return false
        }
        else if authRealName.state == APAuthState.None ||
            authSettleCard.state == APAuthState.None ||
            authSecurity.state == APAuthState.None  {
            ap_pushAuthVC_None()
            return false
        }
        else if authRealName.state == APAuthState.Checking ||
            authSettleCard.state == APAuthState.Checking ||
            authSecurity.state == APAuthState.Checking {
            ap_pushAuthVC_Checking()
            return false
        }
        else if authRealName.state == APAuthState.Failure ||
            authSettleCard.state == APAuthState.Failure ||
            authSecurity.state == APAuthState.Failure {
            ap_pushAuthVC_Failure()
            return false
        }
        else {
            return false
        }
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证----一次都未提交过)
    private func ap_pushAuthVC_frist_None() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "您还未进行身份证认证，请先进行认证"
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let authVC = APRealNameAuthViewController()
            let currentVC = APPDElEGATE.selectTabBarIndex(atIndex: 2)
            currentVC.navigationController?.pushViewController(authVC, animated: true)
        }) { (cancelAction) in
            
        }
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证)
    private func ap_pushAuthVC_None() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "您还未进行身份证认证，请先进行认证"
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let authVC = APAuthHomeViewController()
            let currentVC = APPDElEGATE.selectTabBarIndex(atIndex: 2)
            currentVC.navigationController?.pushViewController(authVC, animated: true)
        }) { (cancelAction) in
            
        }
    }
    
    //MARK: 导航跳转四审状态 (您的资质在审核中，请耐心等待)
    private func ap_pushAuthVC_Checking() {
        
        APAlertManager.show(param: { (param) in
            param.apMessage = "您的资质在审核中，请耐心等待"
            param.apConfirmTitle = "确认"
        }, confirm: {(confirmAction) in
            
        })
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证)
    private func ap_pushAuthVC_Failure() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "您的身份证认证未通过，请重新填写"
            param.apConfirmTitle = "去填写"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let authVC = APAuthHomeViewController()
            let currentVC = APPDElEGATE.selectTabBarIndex(atIndex: 2)
            currentVC.navigationController?.pushViewController(authVC, animated: true)
        }) { (cancelAction) in
            
        }
    }
}

