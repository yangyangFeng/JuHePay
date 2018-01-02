//
//  APGetOnlineTransResultResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码收款结果响应报文模型
 */
class APGetOnlineTransResultResponse: APBaseResponse {
    
    
    @objc dynamic var orderNo: String?
    @objc dynamic var payServiceCode: String?
    @objc dynamic var status: String?
    @objc dynamic var transAmount: String?
    @objc dynamic var transDateTime: String?

}
