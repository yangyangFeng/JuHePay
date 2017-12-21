//
//  APLoginRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APLoginRequest: APBaseRequest {
    
    //账号(手机号)
    @objc dynamic var mobile: String = ""
    //密码
    @objc dynamic var password: String = ""

}
