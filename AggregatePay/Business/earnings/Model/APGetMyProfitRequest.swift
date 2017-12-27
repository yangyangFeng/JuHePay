//
//  APGetMyProfitRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APGetMyProfitRequest: APBaseRequest {
    @objc dynamic var userId : String?
    @objc dynamic var pageNo : String?
    @objc dynamic var startDate : String?
    @objc dynamic var endDate : String?
    
}

class APGetMyProfitResponse: APBaseResponse {
    @objc dynamic var count : String?
    /// 总金额
    @objc dynamic var amount : String?
    /// 总条数
    @objc dynamic var totalRecords : String?
    /// 最后一页
    @objc dynamic var bottomPageNo : String?
    
    
    @objc dynamic var list : [APGetMyProfitResponse]?
    /// 分润id
    @objc dynamic var coProfitDescId : String?
    /// 分润时间
    @objc dynamic var transDate : String?
    /// 分润金额
    @objc dynamic var profitAmount : String?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : [APGetMyProfitResponse.self]]
    }
}
