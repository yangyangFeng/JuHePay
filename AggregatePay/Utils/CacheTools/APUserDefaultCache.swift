//
//  APUserDefaultCache.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APUserDefaultCache: NSObject {
    
    enum APKey: String {
        case session = "session"
        case mobile = "mobile"
        case password = "password"
    }
    
    static func ap_set(value: String, key: APKey) {
        let userDefault = UserDefaults.standard
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    static func ap_get(key: APKey) -> String {
        let userDefault = UserDefaults.standard
        guard let value = userDefault.object(forKey: key.rawValue) else {
            return ""
        }
        return value as! String
    }
    
    static func ap_remove(key: APKey) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key.rawValue)
    }
    
}
