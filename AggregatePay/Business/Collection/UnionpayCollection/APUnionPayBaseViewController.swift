//
//  APUnionPayBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionPayBaseViewController: APBaseViewController {
    
    let UNION_AES_CARD_KEY = AP_AES_Key
    let TRAN_NOTIF_KEY = NSNotification.Name(rawValue: "TRAN_NOTIFICATION_KEY")
    let TRAN_CARD_NOTIF_KEY = NSNotification.Name(rawValue: "TRAN_CARD_NOTIF_KEY")

    var realName: String?        //持卡人姓名
    var totalAmount: String?     // 金额
    var integraFlag: String?     //是否是积分费率
    var payServiceCode: String = "UNIONPAYPAY"
    override func viewDidLoad() {
        super.viewDidLoad()
        ap_setStatusBarStyle(.lightContent)
        if integraFlag == "1" {
            payServiceCode = "UNIONPAYGIFTPAY"
        }
    }

}
