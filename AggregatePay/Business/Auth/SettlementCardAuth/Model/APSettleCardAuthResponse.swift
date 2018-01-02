//
//  APSettleCardAuthResponse.swift
//  AggregatePay
//
//  Created by 沈陈 on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APSettleCardAuthResponse: APBaseResponse {
    @objc dynamic var authDesc: String = ""
    @objc dynamic var authStatus: Int = 0
    @objc dynamic var bankName: String = ""
    @objc dynamic var cardNo: String = ""
    @objc dynamic var idCard: String = ""
    @objc dynamic var realName: String = ""
    @objc dynamic var idCardFront: String = ""
    @objc dynamic var bankNo: String = ""
}
