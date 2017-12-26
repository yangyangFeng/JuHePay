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
typealias APNetWorkingFaileBlock = (_ error: Any) -> Void




/**
 * 网络工具类(常用)
 * 二次封装Alamofire
 * 基本功能:
 *       post请求:
 */
class APNetworking: NSObject {
    
    //请求地址
    let http_url = "http://172.16.0.101:47800"
    
    var manger:SessionManager? = nil
    
    static let sharedInstance = APNetworking()
    
    /**
     * post网络请求
     * @param    httpUrl:前置地址（默认交易前置）
     * @param    action:请求接口(CPCommon.Port)
     * @param    parameters:请求参数
     * @param    success: 请求成功回调
     * @param    faile:   请求失败回调
     */
    static func post(httpUrl: APHttpUrl = .trans_httpUrl,
                     action: APPort,
                     params: APBaseRequest,
                     aClass: Swift.AnyClass,
                     success:@escaping APNetWorkingSuccessBlock,
                     faile:@escaping APNetWorkingFaileBlock) {
        let parameters = params.mj_keyValues() as! Dictionary<String, Any>
        sharedInstance.request(httpUrl: httpUrl,
                               action: action,
                               method: .post,
                               parameters: parameters,
                               success:{ (result) in
            let baseResp = APClassRuntimeTool.ap_class(aClass, result: result) as! APBaseResponse
            if baseResp.isSuccess != "0" {
                success(baseResp)
            }
            else {
                faile(baseResp)
            }
        }) { (error) in
            faile(error)
        }
    }
}




extension APNetworking {
    
    enum APPort: String {
        case login = "/login"
        //注册
        case register = "/user/register"
        //获取验证码 (注册、修改密码）
        case sendMessage = "/manager/sendMessage"
    }
    
    
    enum APHttpUrl: String {
        //交易前置
        case trans_httpUrl = "http://172.16.0.101:47700"
        //进件前置
        case manange_httpUrl = "http://172.16.0.101:47800"
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
        
        let httpUrl = http_url+action.rawValue
        print("===============star===============")
        print("method:"+method.rawValue)
        print("url:"+httpUrl)
        print("param:"+String(describing: parameters))
        print("===============end================")
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeOut
//        headers.
//        let cookieJar = APUserDefaultCache.AP_get(key: .cookies)
        manger = SessionManager(configuration: config)
        manger?.request(httpUrl,
                        method:method,
                        parameters: parameters,
                        headers: headers).responseJSON { response in
                            if (response.result.isSuccess && response.result.error == nil) {
                                self.setCacheCookie(response: response)
                                let result: Dictionary<String, Any>? = try?JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                                success(result!)
                            }
                            else{
                                faile(response.result.error!)
                            }
        }
    }
    
    
    func setCacheCookie(response: DataResponse<Any>) {
        let httpUrlResponse = response.response
        let headerFields = httpUrlResponse?.allHeaderFields
        for key in headerFields! {
            print(key)
        }
        if let cookie = headerFields!["Set-Cookie"] {
            APUserDefaultCache.AP_set(value: cookie as Any, key: .cookies)
        }
    }
   
}










