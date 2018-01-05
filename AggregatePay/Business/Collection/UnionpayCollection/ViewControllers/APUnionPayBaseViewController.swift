//
//  APUnionPayBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionPayBaseViewController: APBaseViewController {
    
    let TRAN_NOTIFICATION_KEY = "APUPETranCallBack_KEY"
    let TRAN_NOTIF_KEY = NSNotification.Name(rawValue: "TRAN_NOTIFICATION_KEY")

    var realName: String?     //持卡人姓名
    var totalAmount: String?  // 金额
    var integraFlag: String?  //是否是积分费率

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
