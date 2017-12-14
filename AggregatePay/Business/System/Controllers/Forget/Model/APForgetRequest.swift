//
//  APModifyRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetRequest: NSObject {
    
    //账号(手机号)
    @objc dynamic var mobile: String = ""
    //新密码
    @objc dynamic var password: String = ""
    //短信验证码
    @objc dynamic var smsCode: String = ""

}
