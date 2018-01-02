//
//  APSecurityAuthResponse.swift
//  AggregatePay
//
//  Created by 沈陈 on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APSecurityAuthResponse: APBaseResponse {
    @objc dynamic var authDate: String?
    @objc dynamic var authDesc: String?
    @objc dynamic var authStatus: Int = 0
    @objc dynamic var bankMobile: String?
    @objc dynamic var cardNo: String?
    @objc dynamic var idCard: String?
    @objc dynamic var realName: String?
}
