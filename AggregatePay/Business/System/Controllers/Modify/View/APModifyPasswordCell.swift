//
//  APNewPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APModifyPasswordCell: APPasswordFormsCell {

    override init() {
        super.init()
        edit.isHidden = true
        textField.placeholder = "请设置密码(6-16位字母、数字或下划线)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
