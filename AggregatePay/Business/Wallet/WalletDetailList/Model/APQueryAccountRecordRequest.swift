//
//  APQueryAccountRecordRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APQueryAccountRecordRequest: APBaseRequest {
    
    //当前页数
    @objc dynamic var pageNo: String = "1"
    
    //每页展示的条数
    @objc dynamic let pageSize: Int = 10
}

