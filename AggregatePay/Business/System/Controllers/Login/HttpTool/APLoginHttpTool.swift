//
//  APLoginHttpTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APLoginHttpTool: NSObject {
    
    
 
    static func keyValue(mirror: Mirror) {
        for property in (mirror.children) {
            let name = property.label!
            let value = property.value
            print("name:\(name) ---- value:\(value)")
        }
        let superMirror = mirror.superclassMirror
        let superClass: String = "\((superMirror?.subjectType)!)"
        if superClass == "NSObject" {
            print("........")
        }
        else {
            keyValue(mirror: superMirror!)
        }
    }

    static func post(paramReqeust: APBaseRequest,
                     success:@escaping (Dictionary<String, Any>)->Void,
                     faile:@escaping (Error)->Void) {
        
        let mirror = Mirror(reflecting: paramReqeust)
        keyValue(mirror: mirror)
        
//
//        APNetworking.post(action: .login,
//                          paramReqeust: paramReqeust,
//                          success: { (result) in
//
//        }) { (error) in
//
//        }
    }
    
}
