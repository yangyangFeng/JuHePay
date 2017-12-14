//
//  APPhoneNumberFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetFirstStepSmsCodeCell: APTextFormsCell {

    override init() {
        super.init()
        predicateInputRegx(inputRegx: "^[0-9]{0,4}$")
        textField.keyboardType = UIKeyboardType.numberPad
        textField.placeholder = "请输入短信验证码"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
