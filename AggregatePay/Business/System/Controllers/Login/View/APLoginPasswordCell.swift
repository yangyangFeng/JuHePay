//
//  APLoginPasswordCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APLoginPasswordCell: APPasswordFormsCell {

    override init() {
        super.init()
        predicateInputRegx(inputRegx: "^[A-Za-z0-9-_]{0,20}$")
        textField.placeholder = "请输入密码"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
