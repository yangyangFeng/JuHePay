//
//  APMerchantCategoryResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APMerchantCategoryResponse: APBaseResponse {
    @objc dynamic var list: [APMerchantDetail]?
}

class APMerchantDetail: NSObject {
    
    @objc dynamic var id: String?
    @objc dynamic var dictKey: String?
    @objc dynamic var dictValue: String?
}
