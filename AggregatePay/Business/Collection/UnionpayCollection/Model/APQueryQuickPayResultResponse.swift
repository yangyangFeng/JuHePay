//
//  APQueryQuickPayResultResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

/** 
 * 查询银联快捷交易结果
 */
class APQueryQuickPayResultResponse: APBaseResponse {
   
    @objc dynamic var id: String?
    @objc dynamic var innerOrderNo: String?
    @objc dynamic var merchantName: String?
    @objc dynamic var merchantNo: String?
    @objc dynamic var transAmount: String?
    @objc dynamic var transTime: String?
}
