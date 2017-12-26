//
//  APRegisterRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterRequest: APBaseRequest {

    //账号(手机号)
    @objc dynamic var mobileNo: String = ""
    //密码
    @objc dynamic var passwd: String = ""
    //邀请码
    @objc dynamic var recommendCode: String = ""
    //短信验证码
    @objc dynamic var idCode: String = ""
    //是否阅读用户协议
    @objc dynamic var isAgreed: Bool = false
    //经纬度
    @objc dynamic var position: String = ""
    
    required override init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = type(of: self).init()
        model.mobileNo = self.mobileNo
        model.passwd = self.passwd
        model.idCode = self.idCode
        model.position = self.position
        model.recommendCode = self.recommendCode
        model.isAgreed = self.isAgreed
        return model
    }
    
}
