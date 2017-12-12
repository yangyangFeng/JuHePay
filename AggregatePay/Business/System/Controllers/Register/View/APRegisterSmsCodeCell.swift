//
//  APSmsCodeFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterSmsCodeCell: APTextFormsCell {

    override init() {
        super.init()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.placeholder = "请输入短信验证码"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
