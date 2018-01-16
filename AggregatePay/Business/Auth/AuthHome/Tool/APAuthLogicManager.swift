//
//  APAuthLogicManager.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/16.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthLogicManager: NSObject {
    static func AP_joinAuthModule(_ block : @escaping (_ controller : UIViewController?,_ authError : APBaseError?) -> ()) {
        APAuthHttpTool.getUserAuthInfo(params: APBaseRequest(), success: { (authInfo) in
            if APAuthHelper.sharedInstance.realNameAuthState == .None {
                let authNavi = APAuthNaviViewController.init(rootViewController: APRealNameAuthViewController())
                block(authNavi,nil)
            }else{
                let authHome = APAuthHomeViewController()
                block(authHome,nil)
            }
        }) {(error) in
            block(nil,error)
        }
    }
}
