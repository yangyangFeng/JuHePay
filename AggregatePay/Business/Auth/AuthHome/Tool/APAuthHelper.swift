//
//  APAuthHelper.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum APAuthType: String {
    case realName, settleCard, Security
}

class APAuthHelper: NSObject {
    
    public var auths: Array<APAuth> = Array()
    public var isFirstAuth: Bool {
        get {
            return checkoutFirstAuth()
        }
    }
    
    public var realNameAuthState: APAuthState = .Other {
        didSet {
            for auth in auths {
                if auth.type == .realName {
                    auth.state = realNameAuthState
                }
            }
        }
    }
    
    public var settleCardAuthState: APAuthState = .Other{
        didSet {
            for auth in auths {
                if auth.type == .settleCard {
                    auth.state = settleCardAuthState
                }
            }
        }
    }
    
    public var securityAuthState: APAuthState = .Other{
        didSet {
            for auth in auths {
                if auth.type == .Security {
                    auth.state = securityAuthState
                }
            }
        }
    }
    
    static let sharedInstance = APAuthHelper()
    private override init(){
        super.init()
        auths = allAuths()
    }
    
    private func allAuths() -> [APAuth] {
        var auths = [APAuth]()
        if let URL = Bundle.main.url(forResource: "APAuth", withExtension: "plist") {
            if let authsFromPlist = NSArray(contentsOf: URL) {
                for dict in authsFromPlist {
                    let auth = APAuth.init(dictionary: dict as! NSDictionary)
                    auths.append(auth)
                }
            }
        }
        return auths
    }
    
    private func checkoutFirstAuth() -> Bool {
        
        var isFirst = true
        for auth in auths {
            if auth.state != .None && auth.state != .Other {
                isFirst = false
            }
        }
        return isFirst
    }
}
