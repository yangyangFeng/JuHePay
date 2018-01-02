//
//  APAuthHomeModel.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import ObjectMapper

/// 用户审核状态
///
/// - None: 未提交
/// - Success: 审核成功
/// - Failure: 审核失败
/// - Checking: 审核中
/// - Close: 该项审核关闭
/// - Other: 审核状态未知

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

class APAuth: NSObject {
    
    var name: String
    var state: APAuthState {
        didSet {
            desc = state.toDesc()
        }
    }
    var desc: String
    var type: APAuthType
    
    init(name: String, state: APAuthState, desc: String, type: APAuthType) {
        self.name = name
        self.state = state
        self.desc = desc
        self.type = type
    }
    
    convenience init(dictionary: NSDictionary) {
        let name = dictionary["name"] as! String
        let state =  dictionary["state"]
        let desc = APAuthState(rawValue: state as! Int)?.toDesc()
        let type = dictionary["type"] as! String
        self.init(name: name, state: APAuthState.init(rawValue: state as! Int)!, desc: desc!, type: APAuthType(rawValue: type)!)
    }
}
