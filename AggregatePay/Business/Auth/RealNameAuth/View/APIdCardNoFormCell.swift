//
//  APIdCardNoFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/17.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APIdCardNoFormCell: APAuthBaseTextFormCell {


    override init() {
        super.init()
        titleLabel.text = "身份证号"
        textField.placeholder = "请输入本人身份证号码"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
