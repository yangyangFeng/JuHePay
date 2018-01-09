//
//  APQueryChannelFessResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 查询银联快捷通道费率
 */
class APQueryChannelFessResponse: APBaseResponse {
    
    @objc dynamic var unionpayGiftBaseFee: String?
    @objc dynamic var unionpayGiftAddD0: String?
    @objc dynamic var unionpayBaseFee: String?
    @objc dynamic var unionpayAddD0: String?
}

