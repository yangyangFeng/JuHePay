//
//  CPNetworking.swift
//  framework
//
//  Created by BlackAnt on 2017/12/4.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit
import Alamofire

typealias APNetWorkingSuccessBlock = (_ result: APBaseResponse) -> Void
typealias APNetWorkingFaileBlock = (_ error: APBaseError) -> Void

/**
 * 网络工具类(常用)
 * 二次封装Alamofire
 * 基本功能:
 *       post请求:
 */
class APNetworking: NSObject {
    
    var manger:SessionManager? = nil
    
    static let sharedInstance = APNetworking()
    
    static func get(httpUrl: APHttpUrl = .trans_httpUrl,
                    action: APPort,
                    params: APBaseRequest,
                    aClass: Swift.AnyClass,
                    success:@escaping APNetWorkingSuccessBlock,
                    faile:@escaping APNetWorkingFaileBlock) {
        sharedInstance.packagingRequest(httpUrl: httpUrl,
                                        action: action,
                                        method: .get,
                                        params: params,
                                        aClass: aClass,
                                        success: success,
                                        faile: faile)
    }
    
    /**
     * post网络请求
     */
    static func post(httpUrl: APHttpUrl = .trans_httpUrl,
                     action: APPort,
                     params: APBaseRequest,
                     aClass: Swift.AnyClass,
                     success:@escaping APNetWorkingSuccessBlock,
                     faile:@escaping APNetWorkingFaileBlock) {
        sharedInstance.packagingRequest(httpUrl: httpUrl,
                                        action: action,
                                        method: .post,
                                        params: params,
                                        aClass: aClass,
                                        success: success,
                                        faile: faile)
    }
}


//MARK: ---- 扩展

extension APNetworking {
    
    enum APPort: String {
        case login              = "/user/login" //登录
        case register           = "/user/register" //注册
        case getUserAccountInfo = "user/getUserAccountInfo"  //钱包余额查询接口(进件前置)
        case sendMessage        = "/manager/sendMessage" //获取验证码 (注册、修改密码）
    }
    
    
    enum APHttpUrl: String {
        case trans_httpUrl = "http://172.16.0.101:47700" //交易前置
        case manange_httpUrl = "http://172.16.0.101:47800"  //进件前置
    }
    
    func packagingRequest(httpUrl: APHttpUrl = .trans_httpUrl,
                          action: APPort,
                          method: HTTPMethod = .post,
                          params: APBaseRequest,
                          aClass: Swift.AnyClass,
                          success:@escaping APNetWorkingSuccessBlock,
                          faile:@escaping APNetWorkingFaileBlock)
    {
        let parameters = params.mj_keyValues() as! Dictionary<String, Any>
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        var requestHeader: HTTPHeaders?
        if cookie != "" {
            requestHeader = ["cookie":cookie]
        }
        request(httpUrl: httpUrl,
                action: action,
                method: method,
                headers: requestHeader,
                parameters: parameters,
                success:{ (result) in
                    print("response:\(String(describing: result))")
                    let baseResp = APClassRuntimeTool.ap_class(aClass, result: result) as! APBaseResponse
                    if baseResp.success != "0" {
                        success(baseResp)
                    }
                    else {
                        let baseError = APClassRuntimeTool.ap_class(APBaseError.self, result: result) as! APBaseError
                        if baseError.status == nil {
                            baseError.status = baseResp.respCode
                            baseError.error = baseResp.respMsg
                        }
                        faile(baseError)
                    }
        }) { (error) in
            let baseError = APBaseError()
            baseError.error = error.localizedDescription
            faile(baseError)
        }
    }
    
    
    /**
     * 网络请求
     * @param   action:请求接口(APCommon.Port)
     * @param   method:请求方式
     * @param   parameters:请求参数
     * @param   success:请求成功回调
     * @param   faile:请求失败回调
     *
     */
    func request(httpUrl: APHttpUrl = .trans_httpUrl,
                 action: APPort,
                 method: HTTPMethod = .get,
                 headers: HTTPHeaders? = nil,
                 timeOut: TimeInterval = 60,
                 parameters:Dictionary<String, Any>,
                 success:@escaping (Dictionary<String, Any>)->Void,
                 faile:@escaping (Error)->Void) {
        
        let httpUrl = httpUrl.rawValue+action.rawValue
        print("===============star===============")
        print("method:"+method.rawValue)
        print("url:"+httpUrl)
        print("param:"+String(describing: parameters))
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeOut
        manger = SessionManager(configuration: config)
        manger?.request(httpUrl,
                        method:method,
                        parameters: parameters,
                        headers: headers).responseJSON { response in
                            if (response.result.isSuccess && response.result.error == nil) {
                                self.cacheCookie(response: response)
                                let result: Dictionary<String, Any>? = try?JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                                success(result!)
                                print("===============end================")
                            }
                            else{
                                print("response:\(String(describing: response.result.error?.localizedDescription))")
                                faile(response.result.error!)
                                print("===============end================")
                            }
        }
    }
    

    func cacheCookie(response: DataResponse<Any>) {
        let httpUrlResponse = response.response
        let headerFields = httpUrlResponse?.allHeaderFields
        if let cookie = headerFields!["Set-Cookie"] {
            APUserDefaultCache.AP_set(value: cookie as Any, key: .cookie)
        }
    }
   
}










