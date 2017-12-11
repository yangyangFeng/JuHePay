//
//  APNewPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APNewPasswordFormsCell: APTitleTextFormsCell {

    override init() {
        super.init()
        title.text = "新密码:"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
