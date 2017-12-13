//
//  APLoginAccountCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APLoginAccountCell: APTextFormsCell {

    override init() {
        super.init()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.placeholder = "请输入11位手机号码"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
