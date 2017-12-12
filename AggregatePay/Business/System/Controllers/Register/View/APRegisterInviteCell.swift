//
//  APInviteCodeFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterInviteCell: APTextFormsCell {

    override init() {
        super.init()
        textField.placeholder = "请输入邀请码"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
