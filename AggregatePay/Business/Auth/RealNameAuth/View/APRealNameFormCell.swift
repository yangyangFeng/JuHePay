//
//  APRealNameFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/17.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRealNameFormCell: APAuthBaseTextFormCell {

    override init() {
        super.init()
        
        titleLabel.text = "真实姓名"
        textField.placeholder = "请输入本人真实姓名"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
