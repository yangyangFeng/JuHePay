//
//  APNetworkRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/12.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit
import Alamofire

class APNetworkRequest: APNetworkUtil {
    
    public static let sharedInstance: APNetworkRequest = {
        let networkRequest = APNetworkRequest()
        networkRequest.ap_careatesessionManager(timeoutIntervalForRequest: 30)
        return networkRequest
    }()
    
    func ap_request(httpUrl: String,
                    method: HTTPMethod = .get,
                    parameters: Parameters? = nil,
                    encoding: ParameterEncoding = URLEncoding.default,
                    headers: HTTPHeaders? = nil,
                    success: @escaping (Dictionary<String, Any>)->Void,
                    failure: @escaping (Error)->Void ) -> DataRequest! {
        
        var request: DataRequest!
        ap_synchronizationQueue.sync {
            print("===============star===============")
            print("method:"+method.rawValue)
            print("url:"+httpUrl)
            print("param:"+String(describing: parameters))
            let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
            var requestHeader: HTTPHeaders?
            if cookie != "" {
                requestHeader = ["cookie":cookie]
            }
            request = ap_sessionManager?.request(httpUrl,
                                                 method: method,
                                                 parameters: parameters,
                                                 headers: requestHeader)
            request.responseJSON(queue: self.ap_responseQueue,
                                 options: .mutableContainers,
                                 completionHandler: {
                                    [weak self] response in
                                    guard let strongSelf = self, let request = response.request else { return }
                                    defer {
                                        strongSelf.ap_safelyDecrementActiveRequestCount()
                                        strongSelf.ap_safelyStartNextRequestIfNecessary()
                                    }
                                    switch response.result {
                                    case .success:
                                        DispatchQueue.main.async {
                                            strongSelf.ap_cacheHttpCookie(headerFields: (response.response?.allHeaderFields)!)
                                            let result = try? JSONSerialization.jsonObject(with: response.data!,  options: .mutableContainers) as! Dictionary<String, Any>
                                            print("result: \(String(describing: result))")
                                            let baseError = strongSelf.ap_error(result: result!)
                                            if baseError != nil {
                                                failure(baseError!)
                                            }
                                            else {
                                                success(result!)
                                            }
                                        }
                                    case .failure:
                                        DispatchQueue.main.async {
                                            let tempError = response.result.error! as NSError
                                            let baseError = APBaseError()
                                            baseError.status = String(describing: tempError.code)
                                            baseError.message = tempError.domain
                                            if baseError.status == "-1009" {
                                                baseError.message = "似乎已断开了与互联网的连接"
                                            }
                                            print("error: \(String(describing: baseError.message))")
                                            failure(baseError)
                                        }
                                    }
                                    print("===============end===============")
            })
            
            if self.ap_isActiveRequestCountBelowMaximumLimit() {
                self.ap_start(request)
            }
            else {
                self.ap_enqueue(request)
            }
        }
        return request
    }

    
    
}
