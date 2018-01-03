//
//  APAuthCommitHttpTool.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHttpTool: NSObject {
    
    // ------------------------------------------------- 获取用户认证信息
    
    /// 获取用户的实名、账户、安全认证信息
    static public func getUserAuthInfo(httpUrl: String = APHttpUrl.manange_httpUrl,
                                       params: APBaseRequest,
                                       success: @escaping (APUserAuthInfo) -> Void,
                                       failure: @escaping (APBaseError) -> Void)
    {
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl,
                         action: APHttpService.userAuthInfo,
                         params: params,
                         aClass: APUserAuthInfo.self,
                         success: { (response) in
            let auths = APAuthHelper.sharedInstance.auths
            let authInfo = response as! APUserAuthInfo
            for auth in  auths{
                switch auth.type {
                case .realName:
                    auth.state = APAuthState(rawValue: authInfo.realNameAuthStatus)!
                case .settleCard:
                    auth.state = APAuthState(rawValue: authInfo.settleCardAuthStatus)!
                case .Security:
                    auth.state = APAuthState(rawValue: authInfo.safeAuthStatus)!
                }
            }
            APAuthHelper.sharedInstance.auths = auths
            success(authInfo)
        }) { (error) in
            failure(error)
        }
    }
    
    // ------------------------------------------------- 三项认证的提交与回显
    
    /// 实名认证
    static public func realNameAuth(params: APRealNameAuthRequest,
                               success: @escaping (APBaseResponse) -> Void,
                               failure: @escaping (APBaseError) -> Void)
    {
        let request = params.copy() as! APRealNameAuthRequest
        request.idCard = aesEncryptString(request.idCard, AP_AES_Key)
        let idCardFront = APFormData.init(image: request.idCardFront!, name: "idCardFront")
        let idCardBack = APFormData.init(image: request.idCardBack!, name: "idCardBack")
        let handIdCard = APFormData.init(image: request.handIdCard!, name: "handIdCard")
        
        auth(params: request,
             formDatas: [idCardFront, idCardBack, handIdCard],
             action: APHttpService.realNameAuth,
             success: success,
             failure: failure)
    }
    /// 实名认证回显
    static public func realNameAuthInfo(params: APBaseRequest,
                                        success: @escaping (APRealNameAuthResponse) -> Void,
                                        failure: @escaping (APBaseError) -> Void)
    {
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl,
                          action: APHttpService.realNameAuthInfo,
                          params: params,
                          aClass: APRealNameAuthResponse.self,
                          success: { (response) in
                            success(response as! APRealNameAuthResponse)
        }) { (error) in
            failure(error)
        }
        
    }
    
    /// 结算卡认证
    static public func settleCardAuth(params: APSettleCardAuthRequest,
                               success: @escaping (APBaseResponse) -> Void,
                               failure: @escaping (APBaseError) -> Void)
    {
        let request = params.copy() as! APSettleCardAuthRequest
        request.identity = aesEncryptString(request.identity, AP_AES_Key)
        request.cardNo = aesEncryptString(request.cardNo, AP_AES_Key)
        let card = APFormData.init(image: request.card!, name: "card")
        
        auth(params: request,
             formDatas: [card],
             action: APHttpService.settleCardAuth,
             success: success,
             failure: failure)
    }
    /// 结算卡认证回显
    static public func settleCardAuthInfo(params: APBaseRequest,
                                          success: @escaping (APSettleCardAuthResponse) -> Void,
                                          failure: @escaping (APBaseError) -> Void)
    {
        
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl,
                          action: APHttpService.settleCardAuthInfo,
                          params: params,
                          aClass: APSettleCardAuthResponse.self,
                          success: { (response) in
                            success(response as! APSettleCardAuthResponse)
        }) { (error) in
            failure(error)
        }
        
    }
    
    /// 安全认证
    static public func securityAuth(params: APSecurityAuthRequest,
                             success: @escaping (APBaseResponse) -> Void,
                             failure: @escaping (APBaseError) -> Void)
    {
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.securityAuth, params: params, aClass: APBaseResponse.self, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    /// 安全认证回显
    static public func securityAuthInfo(params: APBaseRequest,
                                        success: @escaping (APSecurityAuthResponse) -> Void,
                                        failure: @escaping (APBaseError) -> Void)
    {
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl,
                          action: APHttpService.securityAuthInfo,
                          params: params,
                          aClass: APSecurityAuthResponse.self,
                          success: { (response) in
                            success(response as! APSecurityAuthResponse)
        }) { (error) in
            failure(error)
        }
        
    }
    
    /// 认证
    static private func auth(params: APBaseRequest,
                          formDatas: [APFormData],
                             action: String,
                            success: @escaping (APBaseResponse) -> Void,
                            failure: @escaping (APBaseError) -> Void)
    {
        APNetworking.upload(httpUrl: APHttpUrl.manange_httpUrl, action: action, params: params, formDatas: formDatas, aClass: APBaseResponse.self, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
}

