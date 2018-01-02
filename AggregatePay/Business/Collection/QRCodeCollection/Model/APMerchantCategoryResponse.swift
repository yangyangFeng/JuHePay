//
//  APMerchantCategoryResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 获取商户大类响应报文模型
 */
class APMerchantCategoryResponse: APBaseResponse {
    
    @objc dynamic var list: [APMerchantDetail]?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : APMerchantDetail.self]
    }
}

class APMerchantDetail: NSObject {
    
    @objc dynamic var id: String?
    @objc dynamic var dictKey: String?
    @objc dynamic var dictValue: String?
    
}
