//
//  APLoginToolBarView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit


class APLoginMemoryCell: APSelectBoxFormsCell {
    
    override init() {
        super.init()
        button.setTitle(_ : " 记住密码", for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
