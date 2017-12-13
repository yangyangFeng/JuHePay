//
//  APForgetSubmitCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetSubmitCell: APSubmitFormsCell {

    override init() {
        super.init()
        button.theme_setBackgroundImage(["login_nor_button"], forState: .normal)
        button.theme_setBackgroundImage(["login_sel_button"], forState: .selected)
        button.theme_setBackgroundImage(["login_en_button"], forState: .disabled)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
