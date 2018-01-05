//
//  APGetOnlineTransResultRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码收款结果请求报文模型
 */
class APGetOnlineTransResultRequest: APBaseRequest {
    
    @objc dynamic var merchantNo: String?
    @objc dynamic var orderNo: String?
    @objc dynamic var innerOrderNo: String?
    @objc dynamic var terminalNo: String?
    
}
