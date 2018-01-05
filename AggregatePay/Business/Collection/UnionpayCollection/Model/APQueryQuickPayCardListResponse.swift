//
//  APQueryQuickPayCardListResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 获取绑定成功的银联快捷卡列表
 */
class APQueryQuickPayCardListResponse: APBaseResponse {
    @objc dynamic var totalRecords: String?
    @objc dynamic var bottomPageNo: String?
    @objc dynamic var list: [APQueryQuickPayCardDetail]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : APQueryQuickPayCardDetail.self]
    }
}

class APQueryQuickPayCardDetail: NSObject {
    
    @objc dynamic var bankName: String?
    @objc dynamic var cardNo: String?
    @objc dynamic var realName: String?
}
