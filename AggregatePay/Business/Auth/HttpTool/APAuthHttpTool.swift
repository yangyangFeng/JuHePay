//
//  APAuthCommitHttpTool.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHttpTool: NSObject {
    
    static public func realNameAuth(params: APRealNameAuthRequest,
                               success: @escaping (APBaseResponse) -> Void,
                               failure: @escaping (APBaseError) -> Void)
    {
        let request = params.copy() as! APRealNameAuthRequest
        let idCardFront = APFormData.init(image: request.idCardFront!, name: "idCardFront")
        let idCardBack = APFormData.init(image: request.idCardBack!, name: "idCardBack")
        let handIdCard = APFormData.init(image: request.handIdCard!, name: "handIdCard")
        
        auth(params: request,
             formDatas: [idCardFront, idCardBack, handIdCard],
             action: APHttpService.realNameAuth,
             success: success,
             failure: failure)
    }
    
    static public func settleCardAuth(params: APSettleCardAuthRequest,
                               success: @escaping (APBaseResponse) -> Void,
                               failure: @escaping (APBaseError) -> Void)
    {
        let request = params.copy() as! APSettleCardAuthRequest
        let card = APFormData.init(image: request.card, name: "card")
        
        auth(params: request,
             formDatas: [card],
             action: APHttpService.settleCardAuth,
             success: success,
             failure: failure)
    }
    
    static public func securityAuth(params: APSecurityAuthRequest,
                             success: @escaping (APBaseResponse) -> Void,
                             failure: @escaping (APBaseError) -> Void)
    {
        let request = params.copy() as! APSecurityAuthRequest
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.securityAuth, params: request, aClass: APBaseResponse.self, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
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

