//
//  APSystemHttpTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSystemHttpTool: NSObject {
    
    /**
     * 注册
     */
    static func register(paramReqeust: APBaseRequest,
                         success:@escaping (APBaseResponse)->Void,
                         faile:@escaping (String)->Void) {
        APNetworking.post(action: .register,
                          params: paramReqeust,
                          aClass: APBaseResponse.self,
                          success: { (baseResp) in
                            success(baseResp)
        }) { (error) in
            print("------error----")
        }
    }
    
    
    /**
     * 注册-获取短信验证码
     */
    static func sendMessage(paramReqeust: APBaseRequest,
                            success:@escaping (APSendMessageResp)->Void,
                            faile:@escaping (String)->Void) {
        
        APNetworking.post(httpUrl: .manange_httpUrl,
                          action: .sendMessage,
                          params: paramReqeust,
                          aClass: APSendMessageResp.self,
                          success: { (baseResp) in
            success(baseResp as! APSendMessageResp)
        }) { (error) in
            print("------error----")
        }
    }
    
   
    

}





