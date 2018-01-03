//
//  APModifyRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APUpdatePasswordRequest: APBaseRequest, NSCopying {
    
//    @objc dynamic var userId: String = ""
    //旧密码
    @objc dynamic var pwdOld: String  = ""
    //新密码
    @objc dynamic var pwd: String = ""
    //确认密码
    @objc dynamic var pwdConfirm: String  = ""
    
    required override init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = type(of: self).init()
        model.userId = self.userId
        model.pwdOld = self.pwdOld
        model.pwd = self.pwd
        model.pwdConfirm = self.pwdConfirm
        return model
    }
    

}
