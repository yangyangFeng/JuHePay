//
//  APAuthHelper.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum APAuthType: String {
    case realName, settleCard, Security
}

class APAuthHelper: NSObject {
    
    var auths: Array<APAuth>?
    
    static let sharedInstance = APAuthHelper()
    private override init(){}
}
