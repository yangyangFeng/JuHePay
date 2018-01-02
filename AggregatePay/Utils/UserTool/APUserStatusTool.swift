//
//  APUserStatusTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
/**
 tip2：用户权限矩阵图：
             1、依据不同的用户属性，首页展示点击权限如下表，“√”表示可以点击，无此标志则无法点击（或需要进行相应弹窗提示）。
             提示语，
             未认证通过时：您还未进行身份证认证，请先进行认证。 取消、 去认证。
             审核中：您的资质在审核中，请耐心等待。  确认
             未通过：您的身份证认证未通过，请重新填写。 取消、去填写。（进入身份认证界面）
 用户说明：
 1、游客：未注册用户。
 2、弱注册用户：在客户端/H5端，手机号注册成功，未进行身份证认证用户。
 3、认证通过：在客户端已注册成功，并成功通过身份认证的用户。
 4、统一用户身份说明：同一身份证号仅能同时实名认证一个手机号。
 */

//用户状态
enum APUserIdentityStatus: Int {
    case touristsUser   = 1  //游客用户
    case weakUser       = 2  //未做实名认证用户
    case strongUser    = 3  //实名认证通过的用户
}


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

typealias APUserIdentityStatusBlock = (_ param: APUserIdentityStatus) -> Void
typealias APUserAuthStatusBlock = (_ param: APAuthState) -> Void

class APUserStatusTool: NSObject {
    
    static let sharedInstance: APUserStatusTool = APUserStatusTool()

    /** 验证用户身份 */
    static func userIdentityStatusTool(status: APUserIdentityStatusBlock) {
        status(.strongUser)
    }

    /** 验证用户权限状态 */
    static func userAuthStatusTool(status: APUserAuthStatusBlock) {
        status(.None)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
