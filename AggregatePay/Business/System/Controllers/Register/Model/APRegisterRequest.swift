//
//  APRegisterRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterRequest: NSObject {

    //账号(手机号)
    @objc dynamic var mobile: String = ""
    //密码
    @objc dynamic var password: String = ""
    //邀请码
    @objc dynamic var inviteCode: String = ""
    //短信验证码
    @objc dynamic var smsCode: String = ""
    //是否阅读用户协议
    @objc dynamic var isAgreed: Bool = false
    
    
}
