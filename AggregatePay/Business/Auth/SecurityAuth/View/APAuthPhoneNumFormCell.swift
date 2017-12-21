//
//  APAuthPhoneNumFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthPhoneNumFormCell: APAuthBaseTextFormCell {

    override init() {
        super.init()
//        predicateInputRegx(inputRegx: "^1[0-9]{0,10}$")
        titleLabel.text = "预留手机号"
        textField.keyboardType = UIKeyboardType.numberPad
        textField.placeholder = "请输入银行预留手机号"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
