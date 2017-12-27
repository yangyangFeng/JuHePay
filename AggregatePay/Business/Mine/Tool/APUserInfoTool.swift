//
//  APUserInfoTool.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

final class APUserInfoTool: NSObject {
    static var info : APUserInfoTool = {
        var instance = APUserInfoTool()
        return instance
    }()
  
    /// 是否实名
    @objc dynamic var isRealName : String?
    /// 用户名称 ps:当用户已实名才返回
    @objc dynamic var realName : String?
    /// 手机号
    @objc dynamic var mobileNo : String?
    /// 级别名称
    @objc dynamic var levelName : String?
    /// 推荐人名称
    @objc dynamic var recommendUserName : String?
    /// 推荐人手机号
    @objc dynamic var recommendUserMobileNo : String?
}
