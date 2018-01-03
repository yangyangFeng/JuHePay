//
//  APAuthBaseTextFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthBaseTextFormCell: APTextFormsCell {

    let titleLabel = UILabel()
    var enable: Bool = true {
        didSet{
            textField.isUserInteractionEnabled = enable
        }
    }
    
    override init() {
        super.init()
        backgroundColor = UIColor.white
        
        titleLabel.textColor = UIColor.init(hex6: 0x484848)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.backgroundColor = UIColor.white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    
        textField.snp.remakeConstraints{ (make) in
            make.left.equalToSuperview().offset(100)
            make.right.top.bottom.equalToSuperview()
        }
        
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
