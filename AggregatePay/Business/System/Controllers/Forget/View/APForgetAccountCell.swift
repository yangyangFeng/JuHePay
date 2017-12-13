//
//  APMobileFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetAccountCell: APSendSMSCodeFormsCell {
    
    override init() {
        super.init()
        textField.placeholder = "请输入注册手机号"
        sendSmsCodeButton.setTitle(_ : "获取验证码", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
