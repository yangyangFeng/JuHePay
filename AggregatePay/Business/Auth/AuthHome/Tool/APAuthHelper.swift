//
//  APAuthHelper.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum APAuthType: String {
    case realName, settleCard, Security
}

typealias AuthH = APAuthHelper


class APAuthHelper: NSObject {
    
//    var isFirstIn : Bool = true
    static public var auths: Array<APAuth> {
       return APAuthData.authData.auths
    }
    
    public var isFirstAuth: Bool {
        get {
            return checkoutFirstAuth()
        }
    }
    
   static public var realName: APAuthState = .Other {
        didSet {
            for auth in auths {
                if auth.type == .realName {
                    auth.state = realName
                }
            }
        }
    }
    
   static public var settleCard: APAuthState = .Other{
        didSet {
            for auth in auths {
                if auth.type == .settleCard {
                    auth.state = settleCard
                }
            }
        }
    }
    
   static public var security: APAuthState = .Other{
        didSet {
            for auth in auths {
                if auth.type == .Security {
                    auth.state = security
                }
            }
        }
    }
    
    static private var fromViewController: UIViewController!
    
    private func checkoutFirstAuth() -> Bool {
        
        var isFirst = true
        for auth in APAuthHelper.auths {
            if auth.state != .None && auth.state != .Other {
                isFirst = false
            }
        }
        return isFirst
    }
    
    static func clearAuthInfo() {
        
         print("认证信息已清空")
        AuthH.realName = .Other
        AuthH.security = .Other
        AuthH.settleCard = .Other
    }
}

extension APAuthHelper {
    
    
    class func openAuth(
        viewController: UIViewController,
        isAlert: Bool = true) {
        openAuth(viewController: viewController, isAlert: isAlert, success: {
            
        }) { (message) in
        }
    }
    
    class func openAuth(
        viewController: UIViewController,
        isAlert: Bool = true,
        success: @escaping ()-> Void,
        failure: @escaping (_ message: String) -> Void)
    {
        AuthH.fromViewController = viewController
        AuthH.fromViewController.view.AP_loadingBegin()
        
        APAuthHttpTool.getUserAuthInfo(params: APBaseRequest(), success: { (authInfo) in
            
            AuthH.fromViewController.view.AP_loadingEnd()
            
            var message = "您还未进行身份认证，请先进行认证"
            if AuthH.realName == .Success &&
                AuthH.settleCard == .Success &&
                AuthH.security == .Success  {
                
                success()
            }
            else if AuthH.realName == .None &&
                AuthH.settleCard == .None &&
                AuthH.security == .None  {
                
                failure(message)
                AuthH.ap_pushAuthVC_frist_None(message: message, isAlert: isAlert)
                
            }
            else if AuthH.realName == .None ||
                AuthH.settleCard == .None ||
                AuthH.security == .None  {
                
                message = "您还未进行身份认证，请先进行认证"
                AuthH.ap_pushAuthVC_None(message: message, isAlert: isAlert)
                failure(message)
                
            }
            else if AuthH.realName == .Checking ||
                AuthH.settleCard == .Checking ||
                AuthH.security == .Checking {
                
                message = "您的资质在审核中，请耐心等待"
                AuthH.ap_pushAuthVC_Checking(message: message, isAlert: isAlert)
                failure(message)
                
            }
            else if AuthH.realName == .Failure ||
                AuthH.settleCard == .Failure ||
                AuthH.security == .Failure {
                
                message = "您还未进行身份认证，请先进行认证"
                AuthH.ap_pushAuthVC_Failure(message: message, isAlert: isAlert)
                failure(message)
            }
            else {
                message = "审核状态未知"
                AuthH.fromViewController.view.makeToast(message)
                failure(message)
            }
        }) {(error) in
            AuthH.fromViewController.view.AP_loadingEnd()
            AuthH.fromViewController.view.makeToast(error.message)
        }
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证----一次都未提交过)
    class private func ap_pushAuthVC_frist_None(message: String, isAlert: Bool) {
        
        if isAlert {
            APAlertManager.show(param: { (param) in
                param.apMessage = message
                param.apConfirmTitle = "去认证"
                param.apCanceTitle = "取消"
            }, confirm: { (confirmAction) in
                toRealName()
                
            }) { (cancelAction) in
                
            }
        } else {
            toRealName()
        }
    }

    
    
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证)
    class private func ap_pushAuthVC_None(message: String, isAlert: Bool) {
        
        AuthH.toAuthHome(isAlert: isAlert) { (param) in
            param.apMessage = message
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }
    }
    
    //MARK: 导航跳转四审状态 (您的资质在审核中，请耐心等待)
    class private func ap_pushAuthVC_Checking(message: String, isAlert: Bool) {
        
        AuthH.toAuthHome(isAlert: isAlert) { (param) in
            param.apMessage = message
            param.apConfirmTitle = "去查看"
            param.apCanceTitle = "取消"
        }
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证)
    class private func ap_pushAuthVC_Failure(message: String, isAlert: Bool) {
        AuthH.toAuthHome(isAlert: isAlert) { (param) in
            param.apMessage = message
            param.apConfirmTitle = "去填写"
            param.apCanceTitle = "取消"
        }
    }
    
    class func toRealName() {
        let authNavi = APAuthNaviViewController.init(rootViewController: APRealNameAuthViewController())
        
        self.fromViewController.navigationController?.present(
            authNavi,
            animated: true,
            completion: nil)
        
        authNavi.finishAuths = {
            authNavi.dismiss(animated: true, completion: nil)
        }
    }
    
    class func toAuthHome(isAlert: Bool ,param: @escaping (APAlertParam) -> Void) {
        
        if isAlert {
            let alert = APAlertManager.alertController(param: param, confirm: { (confirmAction) in
                let authHomeVC = APAuthHomeViewController()
                AuthH.fromViewController.navigationController?.pushViewController(
                    authHomeVC,
                    animated: true)
                
            }, cancel: nil)
            AuthH.fromViewController.present(
                alert,
                animated: true,
                completion: nil)
        }
        else {
            let authHomeVC = APAuthHomeViewController()
            AuthH.fromViewController.navigationController?.pushViewController(
                authHomeVC,
                animated: true)
        }
    }
}


class APAuthData {
    
    public var auths: Array<APAuth>!
    static let authData = APAuthData()
    private init() {
        auths = allAuths()
    }
    
    private func allAuths() -> [APAuth] {
        var auths = [APAuth]()
        if let URL = Bundle.main.url(forResource: "APAuth", withExtension: "plist") {
            if let authsFromPlist = NSArray(contentsOf: URL) {
                for dict in authsFromPlist {
                    let auth = APAuth.init(dictionary: dict as! NSDictionary)
                    auths.append(auth)
                }
            }
        }
        return auths
    }
}

