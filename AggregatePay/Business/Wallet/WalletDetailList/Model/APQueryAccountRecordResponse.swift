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
    //总条数
    @objc dynamic var totalRecords: String?
    //下页的页数
    @objc dynamic var bottomPageNo: String?
    //明细列表
    @objc dynamic var list: [APQueryAccountRecordListDetail]?
}


//MARK: -------- 明细列表详情
/**
 * 明细列表详情
 */
class APQueryAccountRecordListDetail: NSObject {
    //": 40, //主键
    @objc dynamic var id: String?
    //": 2000,//交易金额
    @objc dynamic var amount: String?
    //": "2017-12-25 03:47:06"//交易日期,
    @objc dynamic var traceDate: String?
    //": "差额",//交易类型
    @objc dynamic var traceType: String?
    //": "0000000020",//流水号
    @objc dynamic var traceNo: String?
    //": 3000,//余额
    @objc dynamic var endAmount: String?
    //": 2//支付模式
    @objc dynamic var payMothed: String?
    
}
