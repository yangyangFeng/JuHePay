//
//  APBankNameFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBankNameFormCell: APAuthBaseTextFormCell {

    
    override init() {
        super.init()
        titleLabel.text = "开户行"
        textField.placeholder = "请选择开户银行"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
