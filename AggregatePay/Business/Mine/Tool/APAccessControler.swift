//
//  APAccessControler.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APAccessControler: NSObject {
    static func checkAccessControl(_ level : Int, result : @escaping ()->Void) {
        switch level {
        case 0:
            result()
            
        case 1:
            if !APUserInfoTool.isLogin() {
                APOutLoginTool.login()
            }
            else
            {
                result()
            }
        case 2:
            if !APUserInfoTool.isLogin() {
                APOutLoginTool.login()
            }
            else{            
                let lastView: UIView = (APPDElEGATE.window?.subviews.last!)!
                lastView.AP_loadingBegin()
                let baseRequest = APBaseRequest()
                baseRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
                APAuthHttpTool.getUserAuthInfo(httpUrl: APHttpUrl.trans_httpUrl, params: baseRequest, success: { (info) in
                    lastView.AP_loadingEnd()
                    if self.ap_userAuthStatus(info: info) {
                        //                    closure()
                        result()
                    }
                }, failure: {(baseError) in
                    lastView.AP_loadingEnd()
                    lastView.makeToast(baseError.message)
                })
            }
            break
        default:
            break
        }
    }
    
    
    private static func ap_userAuthStatus(info: APUserAuthInfo) -> Bool {
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
    private static func ap_pushAuthVC_frist_None() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "您还未进行身份证认证，请先进行认证"
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let authVC = APAuthHomeViewController()
            let currentVC = APPDElEGATE.tabBarSelectController()
            currentVC.navigationController?.pushViewController(authVC, animated: true)
        }) { (cancelAction) in
            
        }
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证)
    private static func ap_pushAuthVC_None() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "您还未进行身份证认证，请先进行认证"
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let authVC = APAuthHomeViewController()
            let currentVC = APPDElEGATE.tabBarSelectController()
            currentVC.navigationController?.pushViewController(authVC, animated: true)
        }) { (cancelAction) in
            
        }
    }
    
    //MARK: 导航跳转四审状态 (您的资质在审核中，请耐心等待)
    private static func ap_pushAuthVC_Checking() {
        
        APAlertManager.show(param: { (param) in
            param.apMessage = "您的资质在审核中，请耐心等待"
            param.apConfirmTitle = "确认"
        }, confirm: {(confirmAction) in
            
        })
    }
    
    //MARK: 导航跳转四审状态 (您还未进行身份证认证，请先进行认证)
    private static func ap_pushAuthVC_Failure() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "您的身份证认证未通过，请重新填写"
            param.apConfirmTitle = "去填写"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            let authVC = APAuthHomeViewController()
            let currentVC = APPDElEGATE.tabBarSelectController()
            currentVC.navigationController?.pushViewController(authVC, animated: true)
        }) { (cancelAction) in
            
        }
    }
}
