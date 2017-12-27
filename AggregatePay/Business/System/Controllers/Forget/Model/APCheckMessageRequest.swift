//
//  APCheckMessageRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCheckMessageRequest: APBaseRequest {
    
    //手机号
    @objc dynamic var mobileNo: String = ""
    
    //短信验证码
    @objc dynamic var idCode: String  = ""

}
