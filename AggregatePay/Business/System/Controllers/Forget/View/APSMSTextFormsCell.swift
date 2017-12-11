//
//  APMobileFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSMSTextFormsCell: APBaseTextFormsCell {

    var text: UITextField = UITextField()
    var smsCode: UIButton = UIButton()
    
    override init() {
        super.init()
        
        title.text = "手机号:"
        smsCode.backgroundColor = UIColor.orange
        addSubview(smsCode)
        addSubview(text)
        
        smsCode.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(100)
        }
        
        text.snp.makeConstraints { (maker) in
            maker.left.equalTo(title.snp.right)
            maker.right.equalTo(smsCode.snp.left)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
