//
//  APAccessControler.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APAccessControler: NSObject {
    static func checkAccessControl(_ level : Int) -> Bool {
        var currentLevel : Int = 0
        
        if APUserInfoTool.isLogin() {
            currentLevel = 0
        }
        if APUserInfoTool.info.isRealName == "0" {
            currentLevel = 1
        }
        else
        {
            currentLevel = 2
        }
        if currentLevel >= level {
            return true
        }
        else
        {
            return false
        }
    }
}
