//
//  APUserStatusTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APUserStatusTool: NSObject {
    
    static let sharedInstance: APUserStatusTool = APUserStatusTool()

    //用户状态
    enum APUserStatus: Int {
        case touristsUser   = 1  //游客用户
        case weakUser       = 2  //未做实名认证用户
        case strongpUser    = 3  //实名认证通过的用户
    }
    
    //用户实名状态
    enum APAuthStatus: Int {
        case defaulAuth   = 1  //待提交
        case auditAuth    = 2  //待审核
        case fauileAuth   = 3  //驳回
        case successAuth  = 4  //成功
    }
    
    /** 当前用户登录状态 */
    lazy var userStatus: APUserStatus = {
        
        let authStatus: APAuthStatus = APUserStatusTool.sharedInstance.authStatus
        let isLogin: Bool = APUserStatusTool.sharedInstance.isLogin
        
        if isLogin && (authStatus == .successAuth) {
            return .strongpUser
        }
        if isLogin && (authStatus != .successAuth) {
            return .weakUser
        }
        return .touristsUser
    }()
    
    /** 当前登录用户的实名状态 */
    var authStatus: APAuthStatus = .defaulAuth
    

    /** 用户是否登录过true:登录过、false:未登录过 */
    lazy var isLogin: Bool = {
        let isMobile = APUserDefaultCache.AP_get(key: .mobile)
        let isPassword = APUserDefaultCache.AP_get(key: .password)
        return isMobile != "" && isPassword != ""
    }()
    
    
    
    
}
