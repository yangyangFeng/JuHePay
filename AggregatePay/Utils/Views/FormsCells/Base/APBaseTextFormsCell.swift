//
//  APBaseTextFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 输入框前面带文字title的表单项
 */
class APBaseTextFormsCell: APBaseFormsCell {
    
    var title: UILabel = UILabel()
    
    override init() {
        super.init()
        topLine.backgroundColor = UIColor.green
        bottomLine.backgroundColor = UIColor.green
        title.backgroundColor = UIColor.red
        
        addSubview(title)
        
        title.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(100)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
