//
//  APGetProfitHomeRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APGetProfitHomeRequest: APBaseRequest {
//    @objc dynamic var userId : String?
    @objc dynamic var mobileNo : String?
}

class APGetProfitHomeResponse: APBaseResponse {
    /// 我推广的人
    @objc dynamic var recommendCount : String?
    /// 累计收益金额
    @objc dynamic var profit : String?
    /// 昨日收益
    @objc dynamic var yearsDayAmount : String?
    /// 推广列表
    @objc dynamic var getRecommendByUser : [APGetProfitHomeResponse]?
    /// 等级id
    @objc dynamic var levelId : String?
    /// 推广人数
    @objc dynamic var userRecommendCount : String?
    /// 等级名称
    @objc dynamic var userLevelName : String?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["getRecommendByUser":self.self]
    }
    


    
}
