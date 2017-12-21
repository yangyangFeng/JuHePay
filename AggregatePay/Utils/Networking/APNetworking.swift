//
//  CPNetworking.swift
//  framework
//
//  Created by BlackAnt on 2017/12/4.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit
import Alamofire

/**
 * 网络工具类(常用)
 * 二次封装Alamofire
 * 基本功能:
 *       post请求:
 */
class APNetworking: NSObject {

    //请求地址
    let http_url = "http://192.168.1.240:29111"
    
    enum APPort: String {
        case login = "/login.action"
    }
    
    var manger:SessionManager? = nil
    
    static let sharedInstance = APNetworking()
    
    /**
     * post网络请求
     * @param    action:请求接口(CPCommon.Port)
     * @param    parameters:请求参数
     * @param    success: 请求成功回调
     * @param    faile:   请求失败回调
     */
    static func post(action: APPort,
                     paramReqeust: APBaseRequest,
                     success:@escaping (Dictionary<String, Any>)->Void,
                     faile:@escaping (Error)->Void) {

        let requestHeader:HTTPHeaders = ["Date":"reqTime"]
        let parameters: Dictionary<String, Any> = Dictionary()
        sharedInstance.request(action: action,
                               method: .post,
                               headers: requestHeader,
                               parameters: parameters,
                               success: success,
                               faile: faile)
        
    }
    
    
    /**
     * 网络请求
     * @param   action:请求接口(APCommon.Port)
     * @param   method:请求方式
     * @param   parameters:请求参数
     * @param   success:请求成功回调
     * @param   faile:请求失败回调
     */
    func request(action: APPort,
                 method: HTTPMethod = .get,
                 headers: HTTPHeaders? = nil,
                 timeOut: TimeInterval = 60,
                 parameters:Dictionary<String, Any>,
                 success:@escaping (Dictionary<String, Any>)->Void,
                 faile:@escaping (Error)->Void) {

        let httpUrl = http_url+action.rawValue
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeOut
        manger = SessionManager(configuration: config)
        manger?.request(httpUrl,
                        method:method,
                        parameters: parameters,
                        headers: headers).responseJSON { response in
                            if (response.result.isSuccess && response.result.error == nil) {
                                let result: Dictionary<String, Any>? = try?JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                                success(result!)
                            }
                            else{
                                faile(response.result.error!)
                            }
        }
    }

}













