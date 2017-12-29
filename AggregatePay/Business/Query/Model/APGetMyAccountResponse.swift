//
//  APGetMyAccountResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/29.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APGetMyAccountResponse: APBaseResponse {
    
    @objc dynamic var amount: String?
    @objc dynamic var count: String?
    @objc dynamic var totalRecords: String?
    @objc dynamic var bottomPageNo: String?
    @objc dynamic var list: [APGetMyAccountDetail]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : APGetMyAccountDetail.self]
    }
    
}


class APGetMyAccountDetail: NSObject {
    
    @objc dynamic var transId: String?
    @objc dynamic var payModel: String?
    @objc dynamic var transAmount: String?
    @objc dynamic var transDate: String?
    @objc dynamic var transType: String?
    
}
