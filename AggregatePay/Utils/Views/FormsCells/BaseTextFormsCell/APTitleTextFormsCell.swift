//
//  APTitleTextFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APTitleTextFormsCell: APBaseTextFormsCell {

    var text: UITextField = UITextField()
    
    override init() {
        super.init()
        
        addSubview(text)
        
        text.snp.makeConstraints { (maker) in
            maker.left.equalTo(title.snp.right)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
