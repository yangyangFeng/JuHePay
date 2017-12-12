//
//  APBaseFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APFormsTextBlock = (_ key: String,_ value: String) -> Void
typealias APFormsButtonBlock = (_ key: String,_ value: Any) -> Void

class APBaseFormsCell: UIView {
    
    var identify: String = ""
    var textBlock: APFormsTextBlock?
    var buttonBlock: APFormsButtonBlock?
   
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
