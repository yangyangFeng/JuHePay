//
//  APNetworkUtil.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/11.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit
import Alamofire

let NEED_LOGIN_NOTIF_KEY = NSNotification.Name(rawValue: "NEED_LOGIN")

class APNetworkUtil: NSObject {
    
    var ap_activeRequestCount: Int = 0
    var ap_maximumActiveRequest: Int = 4
    var ap_timeoutIntervalForRequest: TimeInterval = 30
    var ap_queuedRequests: [Request] = []
    var ap_sessionManager: SessionManager?
   
    let ap_synchronizationQueue: DispatchQueue = {
        let name = String(format: "org.bjzhzf.aggregatepay.apSynchronQueue-%08x%08x",
                          arc4random(),
                          arc4random())
        return DispatchQueue(label: name)
    }()
    
    let ap_responseQueue: DispatchQueue = {
        let name = String(format: "org.bjzhzf.aggregatepay.apResponseQueue-%08x%08x",
                          arc4random(),
                          arc4random())
        return DispatchQueue(label: name)
    }()
    
    override init() {
        super.init()
    }
    
    func ap_careatesessionManager(timeoutIntervalForRequest: TimeInterval = 30) {
        ap_timeoutIntervalForRequest = timeoutIntervalForRequest
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = ap_timeoutIntervalForRequest
        ap_sessionManager = SessionManager(configuration: configuration)
        ap_sessionManager?.delegate.sessionDidReceiveChallenge = { session, challenge in
            return (URLSession.AuthChallengeDisposition.useCredential,
                    URLCredential(trust:challenge.protectionSpace.serverTrust!))
        }
    }
}

extension APNetworkUtil {
    
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
    
    func ap_error(result: Dictionary<String, Any>) -> APBaseError? {
        if !result.keys.contains("isSuccess") &&
            !result.keys.contains("success") {
            let baseError = APBaseError()
            if result.keys.contains("status") {
                baseError.status = result["status"] as? String
                baseError.message = "请求失败"
            }
            return baseError
        }
        else {
            return nil
        }
    }
    
    func ap_checkoutNeedLogin(status: String) -> Bool {
        if status == "NEED_LOGIN" {
            let notification = Notification(name: NEED_LOGIN_NOTIF_KEY,
                                            object: nil,
                                            userInfo: nil)
            NotificationCenter.default.post(notification)
            return true
        }
        return false
    }
    
    func ap_cacheHttpCookie(headerFields: [AnyHashable : Any]) {
        if let cookie = headerFields["Set-Cookie"] {
            print("Set-Cookie: \(cookie)")
            APUserDefaultCache.AP_set(value: cookie as Any, key: .cookie)
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


