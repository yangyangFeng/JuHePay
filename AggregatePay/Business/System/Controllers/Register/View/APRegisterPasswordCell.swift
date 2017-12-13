//
//  APRegisterPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterPasswordCell: APPasswordFormsCell {

    override init() {
        super.init()
        edit.isHidden = true
        textField.placeholder = "请输入密码(6-16位字母、数字或下划线)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
