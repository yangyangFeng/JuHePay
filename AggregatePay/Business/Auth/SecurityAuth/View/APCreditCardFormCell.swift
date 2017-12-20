//
//  APCreditCardFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCreditCardFormCell: APAuthOCRTextFormCell {

    override init() {
        super.init()
        titleLabel.text = "信用卡卡号"
        textField.placeholder = "请输入信用卡卡号"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
