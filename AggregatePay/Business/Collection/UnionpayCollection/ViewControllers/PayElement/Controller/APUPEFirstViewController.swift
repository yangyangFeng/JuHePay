//
//  APUPEFirstViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUPEFirstViewController: APUPERegisViewController {
    
    //交易-获取验证码
    let transMsgRequest = APTransMsgRequest()
    
    //交易-银联快捷
    let quickPayRequest = APQuickPayRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func ap_httpSendSmsCode() {
        
    }
    
    override func ap_httpSubmit() {
        
    }
    
    
    
}
