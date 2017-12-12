//
//  APBaseFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseFormsCell: UIView {
    
    var topLine: UIImageView = UIImageView()
    var bottomLine: UIImageView = UIImageView()
    

    init() {
        super.init(frame: CGRect.zero)
    
        topLine.backgroundColor = UIColor.clear
        bottomLine.backgroundColor = UIColor.clear
        
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
