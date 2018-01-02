//
//  APAccountRecordResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

//MARK: -------- 明细列表
/**
 * 明细列表
 */
class APQueryAccountRecordResponse: APBaseResponse {
    
    @objc dynamic var totalRecords: String?
    @objc dynamic var bottomPageNo: String?
    @objc dynamic var list: [APQueryAccountRecordListDetail]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : APQueryAccountRecordListDetail.self]
    }
}


//MARK: -------- 明细列表详情
/**
 * 明细列表详情
 */
class APQueryAccountRecordListDetail: NSObject {
    @objc dynamic var id: String?
    @objc dynamic var amount: String?
    @objc dynamic var traceDate: String?
    @objc dynamic var traceType: String?
    @objc dynamic var traceNo: String?
    @objc dynamic var endAmount: String?
    @objc dynamic var payMothed: String?
}
