//
//  APResetPasswordRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APResetPasswordRequest: APBaseRequest, NSCopying {
    
    //手机号
    @objc dynamic var mobileNo: String = ""
    //业务类型1:修改密码 2:找回密码
    @objc dynamic var optType: String = "1"
    //新密码
    @objc dynamic var pwd: String = ""
    //确认密码
    @objc dynamic var pwdConfirm: String  = ""
    

    required override init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = type(of: self).init()
        model.mobileNo = self.mobileNo
        model.optType = self.optType
        model.pwd = self.pwd
        model.pwdConfirm = self.pwdConfirm
        return model
    }
    
}
