//
//  APAuthHomeModel.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import ObjectMapper

class APAuth: NSObject {
    
    class func allAuths() -> [APAuth] {
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
    
    var name: String
    var state: APAuthState
    var desc: String
    var type: APAuthType
    
    init(name: String, state: APAuthState, desc: String, type: APAuthType) {
        self.name = name
        self.state = state
        self.desc = desc
        self.type = type
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["name"] as! String
        let state =  dictionary["state"]
        let desc = APAuthState(rawValue: state as! Int)?.toDesc()
        let type = dictionary["type"] as! String
        self.init(name: name, state: APAuthState.init(rawValue: state as! Int)!, desc: desc!, type: APAuthType(rawValue: type)!)
    }
}
