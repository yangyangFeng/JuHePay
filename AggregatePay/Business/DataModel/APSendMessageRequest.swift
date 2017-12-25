//
//  APSendMessageRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSendMessageRequest: APBaseRequest {
    var mobileNo : String?
    ///  1:注册.2:找回密码
    var businessType : Int?
    
}
