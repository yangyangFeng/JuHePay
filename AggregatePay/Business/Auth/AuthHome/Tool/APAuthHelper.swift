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

enum APAuthState: Int {
    case None = 0, Success, Failure, Checking, Close, Other
    
    func toDesc() -> String {
        switch self {
        case .None:
            return "未提交"
        case .Success:
            return "已通过"
        case .Failure:
            return "审核未通过"
        case .Checking:
            return "审核中"
        case .Close:
            return "审核关闭"
        default:
            return "审核状态未知"
        }
    }
}

class APAuthHelper: NSObject {
    
    var auths: Array<APAuth>?
    
    static let sharedInstance = APAuthHelper()
    private override init(){}
}
