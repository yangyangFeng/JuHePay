//
//  APSendMessageResq.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSendMessageReq: APBaseRequest {
    
    //账号(手机号)
    @objc dynamic var mobileNo: String = ""
    //业务类型（1、注册、2、找回密码）
    @objc dynamic var businessType: String = ""

}
