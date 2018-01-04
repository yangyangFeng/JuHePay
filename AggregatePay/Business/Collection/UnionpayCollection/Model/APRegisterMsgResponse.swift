//
//  APRegisterMsgResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

/** post
 * 银联快捷开通验证码
 */
class APRegisterMsgResponse: APBaseResponse {
    @objc dynamic var smsCode: String?
    @objc dynamic var preSerial: String?
}
