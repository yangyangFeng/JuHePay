//
//  APRealNameAuthRequest.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRealNameAuthRequest: APBaseRequest, NSCopying {
    
    //身份证号
    @objc dynamic var idCard: String = ""
    //用户ID
//    @objc dynamic var userId: String = ""
    //真实姓名
    @objc dynamic var realName: String = ""
    //身份证正面照片
    @objc dynamic var idCardFront: UIImage?
    //身份证背面照片
    @objc dynamic var idCardBack: UIImage?
    //手持身份证半身照
    @objc dynamic var handIdCard: UIImage?
    
    required override init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let model = type(of: self).init()
        model.idCard = idCard
        model.userId = userId
        model.realName = realName
        model.idCardFront = idCardFront
        model.idCardBack = idCardBack
        model.handIdCard = handIdCard
        return model
    }
    
    override static func mj_ignoredPropertyNames() -> [Any]! {
        return ["idCardFront", "idCardBack", "handIdCard"]
    }
}
