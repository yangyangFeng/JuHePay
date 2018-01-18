//
//  APAccessControler.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APAccessControler: NSObject {
    static func checkAccessControl(_ viewController : UIViewController,level : Int, result : @escaping ()->Void) {
        switch level {
        case 0:
            result()
            
        case 1:
            if !APUserInfoTool.isLogin() {
                APOutLoginTool.login()
            }
            else
            {
                AuthH.openAuth(success: {
                    result()
                }, failure: { (msg) in
                    
                })
            }
        case 2:
            if !APUserInfoTool.isLogin() {
                APOutLoginTool.login()
            }
            else{
                AuthH.openAuth(success: {
                    result()
                }, failure: { (msg) in
                    
                })
            }
            break
        default:
            break
        }
    }
}
