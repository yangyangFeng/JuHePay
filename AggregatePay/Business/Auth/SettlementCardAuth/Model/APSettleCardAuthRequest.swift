//
//  APSettleCardAuthRequest.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSettleCardAuthRequest: APBaseRequest, NSCopying {
    
    /// 用户ID
    @objc dynamic var userId: String = ""
    
    /// 身份证号，做AES加密
    @objc dynamic var identity: String = ""
    
    /// 姓名
    @objc dynamic var userName: String = ""
    
    /// 结算卡号
    @objc dynamic var cardNo: String = ""
    
    /// 结算卡发卡行
    @objc dynamic var bankName: String = ""
    
    /// 结算卡正面照片
    @objc dynamic var card: UIImage = UIImage()
    
    required override init() {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        let model = type(of: self).init()
        
        model.userId = self.userId
        model.identity = self.identity
        model.userName = self.userName
        model.cardNo = self.cardNo
        model.bankName = self.bankName
        model.card = self.card
        
        return model
    }
    
}
