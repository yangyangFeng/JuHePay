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

    var manger:SessionManager? = nil
    
    static let sharedInstance = APNetworking()
    
    /**
     * post网络请求
     * @param    action:请求接口(CPCommon.Port)
     * @param    parameters:请求参数
     * @param    success: 请求成功回调
     * @param    faile:   请求失败回调
     */
    static func post(action:APCommon.APPort,
                     parameters:Dictionary<String, Any>,
                     success:@escaping (Dictionary<String, Any>)->Void,
                     faile:@escaping (Error)->Void) {
        sharedInstance.request(action: action,
                               method: .post,
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
    func request(action:APCommon.APPort,
                 method:HTTPMethod,
                 parameters:Dictionary<String, Any>,
                 success:@escaping (Dictionary<String, Any>)->Void,
                 faile:@escaping (Error)->Void) {
        let httpUrl = APCommon.http_url+action.rawValue
        let requestHeader:HTTPHeaders = ["Date":""]
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        manger = SessionManager(configuration: config)
        manger?.request(httpUrl,
                        method:method,
                        parameters: parameters,
                        headers: requestHeader).responseJSON { response in
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













