//
//  APSystemHttpTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSystemHttpTool: NSObject {
    
    //MARK: -- 注册
    /**
     * 注册
     */
    static func register(paramReqeust: APRegisterRequest,
                         success:@escaping (APBaseResponse)->Void,
                         faile:@escaping (String)->Void) {
        let param: APRegisterRequest = paramReqeust.copy() as! APRegisterRequest
        param.passwd = CPMD5EncrpTool.md5(forLower32Bate: paramReqeust.passwd)
        APNetworking.post(httpUrl: .manange_httpUrl,
                          action: .register,
                          params: param,
                          aClass: APBaseResponse.self,
                          success: { (baseResp) in
            success(baseResp)
        }) { (error) in
            faile(error.error!)
        }
    }
    
    //MARK: -- 登录
    /**
     * 登录
     */
    static func login(paramReqeust: APLoginRequest,
                      success:@escaping (APBaseResponse)->Void,
                      faile:@escaping (String)->Void) {
        let param: APLoginRequest = paramReqeust.copy() as! APLoginRequest
        param.passwd = CPMD5EncrpTool.md5(forLower32Bate: paramReqeust.passwd)
        APNetworking.post(httpUrl: .trans_httpUrl,
                          action: .login,
                          params: param,
                          aClass: APLoginResponse.self,
                          success: { (baseResp) in
                            success(baseResp)
        }) { (error) in
            faile(error.error!)
        }
    }
    
    //MARK: -- 忘记密码
    /**
     * 忘记密码
     */
    static func forgetPassword(paramReqeust: APResetPasswordRequest,
                              success:@escaping (APBaseResponse)->Void,
                              faile:@escaping (String)->Void) {
        let param: APResetPasswordRequest = paramReqeust.copy() as! APResetPasswordRequest
        param.pwd = CPMD5EncrpTool.md5(forLower32Bate: paramReqeust.pwd)
        param.pwdConfirm = CPMD5EncrpTool.md5(forLower32Bate: paramReqeust.pwdConfirm)
        APNetworking.post(httpUrl: .manange_httpUrl,
                          action: .resetPassword,
                          params: param,
                          aClass: APBaseResponse.self,
                          success: { (baseResp) in
                            success(baseResp)
        }) { (error) in
            faile(error.error!)
        }
    }
    
    
    //MARK: -- 获取短信验证码
    /**
     * 获取短信验证码
     */
    static func sendMessage(paramReqeust: APSendMessageReq,
                            success:@escaping (APBaseResponse)->Void,
                            faile:@escaping (String)->Void) {
        APNetworking.post(httpUrl: .manange_httpUrl,
                          action: .sendMessage,
                          params: paramReqeust,
                          aClass: APBaseResponse.self,
                          success: { (baseResp) in
                            success(baseResp)
        }) { (error) in
            faile(error.error!)
        }
    }
    
    
    //MARK: -- 验证短信验证码
    /**
     * 验证短信验证码
     */
    static func checkMessage(paramReqeust: APCheckMessageRequest,
                             success:@escaping (APBaseResponse)->Void,
                             faile:@escaping (String)->Void) {
        APNetworking.post(httpUrl: .manange_httpUrl,
                          action: .checkMessage,
                          params: paramReqeust,
                          aClass: APBaseResponse.self,
                          success: { (baseResp) in
                            success(baseResp)
        }) { (error) in
            faile(error.error!)
        }
    }
    
    
    

}





