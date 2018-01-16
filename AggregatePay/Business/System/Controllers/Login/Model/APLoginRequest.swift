//
//  APLoginRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APLoginRequest: APBaseRequest, NSCopying {
    
    //账号(手机号)
    @objc dynamic var mobileNo: String = ""
    //密码
    @objc dynamic var passwd: String = ""
    //是否记住密码
    @objc dynamic var isRemember: String = "0"
    //激光推送唯一标识
    @objc dynamic var registId: String = JPUSHService.registrationID()
    
    required override init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = type(of: self).init()
        model.mobileNo = self.mobileNo
        model.passwd = self.passwd
        model.registId = self.registId
        model.isRemember = self.isRemember
        return model
    }
}
