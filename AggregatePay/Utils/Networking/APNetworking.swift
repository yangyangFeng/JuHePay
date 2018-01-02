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
    
    var manger:SessionManager?
    var dataRequest:DataRequest?
    
    static let sharedInstance = APNetworking()
    
    static func get(httpUrl: String = APHttpUrl.trans_httpUrl,
                    action: String,
                    params: APBaseRequest,
                    aClass: Swift.AnyClass,
                    success: @escaping APNetWorkingSuccessBlock,
                    failure faile: APNetWorkingFaileBlock? = nil) {
        
        
        sharedInstance.packagingRequest(httpUrl: httpUrl,
                                        action: action,
                                        method: .get,
                                        params: params,
                                        aClass: aClass,
                                        success: success,
                                        failure: faile)
    }
    
    /**
     * post网络请求
     */
    static func post(httpUrl: String = APHttpUrl.trans_httpUrl,
                     action: String,
                     params: APBaseRequest,
                     aClass: Swift.AnyClass,
                     success:@escaping APNetWorkingSuccessBlock,
                     failure faile: APNetWorkingFaileBlock? = nil) {
        sharedInstance.packagingRequest(httpUrl: httpUrl,
                                        action: action,
                                        method: .post,
                                        params: params,
                                        aClass: aClass,
                                        success: success,
                                        failure: faile)
    }
    
    /**
     * 取消当前网络请求
     */
    static func cancelCurrentRequest() {
        sharedInstance.dataRequest?.cancel()
    }
}

//extension

//MARK: ---- 扩展

extension APNetworking {

    func packagingRequest(httpUrl: String = APHttpUrl.trans_httpUrl,
                          action: String,
                          method: HTTPMethod = .post,
                          params: APBaseRequest,
                          aClass: Swift.AnyClass,
                          success:@escaping APNetWorkingSuccessBlock,
                          failure faile: APNetWorkingFaileBlock? = nil)
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
                    let baseResp = APClassRuntimeTool.ap_class(aClass, result: result) as! APBaseResponse
                    if baseResp.success == nil && baseResp.isSuccess == nil {
                        faile?(self.error(result: result))
                    }
                    else if baseResp.success == "0" || baseResp.isSuccess == "0" {
                        let baseError = APBaseError()
                        baseError.status = baseResp.respCode
                        baseError.message = baseResp.respMsg
                        if !self.checkoutNeedLogin(status: baseError.status!) {
                            faile?(baseError)
                        }
                    }
                    else {
                        success(baseResp)
                    }
        }) { (error) in
            let baseError = APBaseError()
            baseError.status = error.localizedDescription
            baseError.message = error.localizedDescription
            faile?(baseError)
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
    func request(httpUrl: String = APHttpUrl.trans_httpUrl,
                 action: String,
                 method: HTTPMethod = .get,
                 headers: HTTPHeaders? = nil,
                 timeOut: TimeInterval = 30,
                 parameters:Dictionary<String, Any>,
                 success:@escaping (Dictionary<String, Any>)->Void,
                 faile:@escaping (Error)->Void) {
        
        let httpUrl = httpUrl+action
        print("===============star===============")
        print("method:"+method.rawValue)
        print("url:"+httpUrl)
        print("param:"+String(describing: parameters))
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeOut
        manger = SessionManager(configuration: config)
        manger?.delegate.sessionDidReceiveChallenge = { session, challenge in
            return (URLSession.AuthChallengeDisposition.useCredential,
                    URLCredential(trust:challenge.protectionSpace.serverTrust!))
        }
        dataRequest = manger?.request(httpUrl,
                                      method:method,
                                      parameters: parameters,
                                      headers: headers).responseJSON { response in
                            switch response.result.isSuccess {
                            case true:
                                self.cacheCookie(response: response)
                                print("response-value:\(String(describing: response.value))")
                                success(response.value! as! Dictionary<String, Any>)
                                print("===============end================")
                            case false:
                                
                                print("response:\(String(describing: response.result.error?.localizedDescription))")
                                faile(response.result.error!)
                                print("===============end================")
                            }
        }
    }
    
    func checkoutNeedLogin(status: String) -> Bool {
        if status == "NEED_LOGIN" {
            NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "NEED_LOGIN"), object: nil, userInfo: nil))
            return true
        }
        return false
    }
    
    func error(result: Dictionary<String, Any>) -> APBaseError {
        let baseError = APClassRuntimeTool.ap_class(APBaseError.self, result: result) as! APBaseError
        if baseError.status == "404" {
            baseError.message = "请求服务器失败"
        }
        else {
            baseError.message = "请求服务器失败"
        }
        return baseError
    }
    
    
    func cacheCookie(response: DataResponse<Any>) {
        let httpUrlResponse = response.response
        let headerFields = httpUrlResponse?.allHeaderFields
        if let cookie = headerFields!["Set-Cookie"] {
            APUserDefaultCache.AP_set(value: cookie as Any, key: .cookie)
        }
    }
   
}










