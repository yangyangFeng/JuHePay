//
//  APBaseRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseRequest: NSObject {
    
    //版本号
    var appVersion: String = "ios.ZFT.1.3.6"
    
    //请求时间
    var reqTime: String = APDateTools.stringToDate(date: Date());
    
    //默认  ZFT
    var product: String = "ZFT"
    
    
    
}
