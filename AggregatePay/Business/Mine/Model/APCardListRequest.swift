//
//  APCardListRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCardListRequest: APBaseRequest {
//    @objc dynamic var userId : String?
    /// 1：借记卡 2：贷记卡
    @objc dynamic var cardType : String?
    /// 非必须
    @objc dynamic var isSettle : String?
    
}

class APCardListResponse: APBaseResponse {
    
    @objc dynamic var list : [Any]?
    
    /// 认证卡id
    @objc dynamic var authCardId : String?
    @objc dynamic var bankName : String?
    @objc dynamic var cardNo : String?
    @objc dynamic var userId : String?
    @objc dynamic var userName : String?
    @objc dynamic var identity : String?
    @objc dynamic var cardType : String?
    /// 认证类型
    @objc dynamic var authType : String?
    /// 是否结算卡
    @objc dynamic var isSettle : String?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list":APCardListResponse.self]
    }
}
