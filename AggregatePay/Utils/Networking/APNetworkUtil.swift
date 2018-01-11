//
//  APNetworkUtil.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/11.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit
import Alamofire

class APNetworkUtil: NSObject {
    
    var ap_activeRequestCount: Int = 0
    var ap_maximumActiveRequest: Int = 0
    var ap_queuedRequests: [Request] = []
    var ap_sessionManager: SessionManager
   
    private let ap_synchronizationQueue: DispatchQueue = {
        let name = String(format: "org.bjzhzf.aggregatepay.apSynchronQueue-%08x%08x",
                          arc4random(),
                          arc4random())
        return DispatchQueue(label: name)
    }()
    
    private let ap_responseQueue: DispatchQueue = {
        let name = String(format: "org.bjzhzf.aggregatepay.apResponseQueue-%08x%08x",
                          arc4random(),
                          arc4random())
        return DispatchQueue(label: name)
    }()
    
    public static let shared: APNetworkUtil = {
        let sessionManager = APNetworkUtil.ap_sessionManager()
        return APNetworkUtil(sessionManager: sessionManager)
    }()
    
    init(sessionManager: SessionManager, maximumActiveRequest: Int = 4) {
        
        self.ap_sessionManager = sessionManager
        self.ap_maximumActiveRequest = maximumActiveRequest
    }
    
    func ap_request(httpUrl: String,
                    method: HTTPMethod = .get,
                    parameters: Parameters? = nil,
                    encoding: ParameterEncoding = URLEncoding.default,
                    headers: HTTPHeaders? = nil,
                    success: @escaping (DataResponse<Any>) -> Void,
                    failure: @escaping (Error)->Void ) -> DataRequest! {
        
        var request: DataRequest!
        ap_synchronizationQueue.sync {
            print("===============star===============")
            print("method:"+method.rawValue)
            print("url:"+httpUrl)
            print("param:"+String(describing: parameters))
            request = self.ap_sessionManager.request(httpUrl,
                                                     method: method,
                                                     parameters: parameters,
                                                     headers: headers)
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
                                            success(response)
                                            print("===============end===============")
                                        }
                                    case .failure:
                                        DispatchQueue.main.async {
                                            print("Failure: "+(response.result.error?.localizedDescription)! as Any)
                                            failure(response.result.error!)
                                            print("===============end===============")
                                        }
                                    }

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

extension APNetworkUtil {
    
    static func ap_sessionManager(_ timeoutIntervalForRequest: TimeInterval = 30) -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        
        let manager = SessionManager(configuration: configuration)
        
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            return (URLSession.AuthChallengeDisposition.useCredential,
                    URLCredential(trust:challenge.protectionSpace.serverTrust!))
        }
        return manager
    }
    
    func ap_safelyStartNextRequestIfNecessary() {
        ap_synchronizationQueue.sync {
            guard self.ap_isActiveRequestCountBelowMaximumLimit() else { return }
            while !self.ap_queuedRequests.isEmpty {
                if let request = self.ap_dequeue(), request.task?.state == .suspended {
                    self.ap_start(request)
                    break
                }
            }
        }
    }
    
    func ap_safelyDecrementActiveRequestCount() {
        self.ap_synchronizationQueue.sync {
            if self.ap_activeRequestCount > 0 {
                self.ap_activeRequestCount -= 1
            }
        }
    }
}

extension APNetworkUtil {
    
    func ap_enqueue(_ request: Request) {
        ap_queuedRequests.append(request)
    }
    
    func ap_start(_ request: Request) {
        request.resume()
        ap_activeRequestCount += 1
    }
    
    func ap_dequeue() -> Request? {
        var request: Request?
        if !ap_queuedRequests.isEmpty {
            request = ap_queuedRequests.removeFirst()
        }
        return request
    }
    
    func ap_isActiveRequestCountBelowMaximumLimit() -> Bool {
        return ap_activeRequestCount < ap_maximumActiveRequest
    }
}

class APRequestReceipt {
    let ap_request: Request
    let ap_receiptID: String
    
    init(request: Request, receiptID: String) {
        self.ap_request = request
        self.ap_receiptID = receiptID
    }
}



