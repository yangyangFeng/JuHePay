//
//  APForgetSubmitCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetFirstStepSubmitCell: APSubmitFormsCell {

    override init() {
        super.init()
        button.setTitle("提交", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
