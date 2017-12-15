//
//  APMobileFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetFirstStepAccountCell: APSendSMSCodeFormsCell {
    
    override init() {
        super.init()
        predicateInputRegx(inputRegx: "^1[0-9]{0,10}$")
        sendSmsCodeButton.setTitle(_ : "获取验证码", for: .normal)
        textField.placeholder = "请输入注册手机号"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
