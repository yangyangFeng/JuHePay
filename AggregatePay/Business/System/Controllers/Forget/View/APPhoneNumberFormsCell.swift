//
//  APPhoneNumberFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPhoneNumberFormsCell: APTitleTextFormsCell {

    override init() {
        super.init()
        title.text = "验证码:"
        topLine.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
