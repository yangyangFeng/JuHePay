//
//  APQRCodePayResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit


/**
 * 生成二维码响应报文模型
 */
class APQRCodePayResponse: APBaseResponse {
    
    @objc dynamic var codeUrl: String?
    @objc dynamic var cerateDate: String?
    @objc dynamic var innerOrderNo: String?
    @objc dynamic var merchantName: String?
    @objc dynamic var merchantNo: String?
    @objc dynamic var orderNo: String?
    @objc dynamic var terminalNo: String?
    @objc dynamic var transAmount: String?
    @objc dynamic var userId: String?
    @objc dynamic var validTime: String?
    
}
