//
//  APQRCodeBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APQRCodeBaseViewController: APBaseViewController {
    
    var payType: String?
    var amountStr: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch payType! {
        case "wechatPay":
            self.title = "微信收款"
        case "aliPay":
            self.title = "支付宝收款"
        default:
            self.title = "二维码收款"
        }
    }

    

}
