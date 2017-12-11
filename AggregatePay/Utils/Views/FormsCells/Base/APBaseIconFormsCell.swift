//
//  APBaseIconFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 输入框前面带图标title的表单项
 */
class APBaseIconFormsCell: APBaseFormsCell {
    
    var icon: UIImageView = UIImageView()

    override init() {
        super.init()
        bottomLine.backgroundColor = UIColor.green
        icon.backgroundColor = UIColor.red
        
        addSubview(icon)
        
        icon.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
