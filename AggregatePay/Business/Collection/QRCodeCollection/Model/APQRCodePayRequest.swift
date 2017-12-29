//
//  APQRCodePayRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 生成二维码请求报文模型
 */
class APQRCodePayRequest: APBaseRequest {

    @objc dynamic var userId: String = ""
    @objc dynamic var transAmount: String?
    @objc dynamic var categroyCode: String?
    
}
