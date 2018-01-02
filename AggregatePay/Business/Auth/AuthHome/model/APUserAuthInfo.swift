//
//  APUserAuthInfo.swift
//  AggregatePay
//
//  Created by 沈陈 on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUserAuthInfo: APBaseResponse {
    @objc dynamic var realNameAuthMsg: String?
    @objc dynamic var realNameAuthStatus: Int = 0
    @objc dynamic var safeAuthMsg: String?
    @objc dynamic var safeAuthStatus: Int = 0
    @objc dynamic var settleCardAuthMsg: String?
    @objc dynamic var settleCardAuthStatus: Int = 0

}
