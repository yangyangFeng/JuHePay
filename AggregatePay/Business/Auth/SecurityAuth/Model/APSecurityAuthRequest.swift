//
//  APSecurityAuthRequest.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSecurityAuthRequest: APBaseRequest, NSCopying {
    @objc dynamic var userId: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var idCard: String = ""
    @objc dynamic var cardNo: String = ""
    @objc dynamic var mobileNo: String = ""
    
    override required init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = type(of: self).init()
        
        model.userId = self.userId
        model.userName = self.userName
        model.idCard = self.idCard
        model.cardNo = self.cardNo
        model.mobileNo = self.mobileNo
        
        return model
    }
}
