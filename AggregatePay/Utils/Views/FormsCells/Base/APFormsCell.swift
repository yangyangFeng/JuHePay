//
//  APFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APFormsCell: APBaseFormsCell {

    var topLine: UIImageView = UIImageView()
    var bottomLine: UIImageView = UIImageView()
    
    override init() {
        super.init()
        
        topLine.backgroundColor = UIColor.clear
        bottomLine.theme_backgroundColor = ["#f4f4f4"]
        
        addSubview(topLine)
        addSubview(bottomLine)
        
        topLine.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(self.snp.top)
            maker.height.equalTo(1)
        }
        
        bottomLine.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.bottom).offset(-1)
            maker.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
