//
//  APRegisterAccountCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterAccountCell: APSendSMSCodeFormsCell {
    
    override init() {
        super.init()
        textField.placeholder = "请输入11位手机号码"
        textField.keyboardType = UIKeyboardType.numberPad
        sendSmsCodeButton.setTitle(_ : "发送短信验证码", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
