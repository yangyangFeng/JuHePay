//
//  APUserDefaultCache.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APUserDefaultCache: NSObject {
    
    enum APUserDefaultKey: String {
        case mobile = "mobile"
        case password = "password"
        case cookies = "cookies"
    }
    
    static func AP_set(value: Any, key: APUserDefaultKey) {
        let userDefault = UserDefaults.standard
        userDefault.set(value, forKey: key.rawValue)
        userDefault.synchronize()
    }
    
    static func AP_get(key: APUserDefaultKey) -> Any {
        let userDefault = UserDefaults.standard
        guard let value = userDefault.object(forKey: key.rawValue) else {
            return ""
        }
        return value as! String
    }
    
    static func AP_remove(key: APUserDefaultKey) {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: key.rawValue)
    }
    
}
