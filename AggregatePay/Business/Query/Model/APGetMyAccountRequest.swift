//
//  APGetMyAccountRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/29.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APGetMyAccountRequest: APBaseRequest {
    
    @objc dynamic var startDate: String?
    @objc dynamic var endDate: String?
    @objc dynamic var payModel: String?
    @objc dynamic var pageNo: Int = 1

}
