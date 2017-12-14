//
//  APNewPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetLastStepPasswordCell: APPasswordFormsCell {

    override init() {
        super.init()
        predicateInputRegx(inputRegx: "^[A-Za-z0-9-_]{0,20}$")
        textField.placeholder = "请设置密码(6-16位字母、数字或下划线)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
