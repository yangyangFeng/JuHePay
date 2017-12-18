//
//  APPayEssentialCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 输入支付要素子视图（带标题和输入框cell）
 */
class APPayElementTextCell: APBaseFormsCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        return view
    }()
    
    let textCell: APTextFormsCell = APTextFormsCell()

    override init() {
        super.init()
        
        backgroundColor = UIColor.white
        
        textCell.bottomLine.backgroundColor = UIColor.clear
        textCell.textField.keyboardType = UIKeyboardType.numberPad
        
        addSubview(titleLabel)
        addSubview(textCell)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(80)
        }
        
        textCell.snp.makeConstraints { (maker) in
            maker.left.equalTo(titleLabel.snp.right).offset(10)
            maker.right.equalTo(self.snp.right).offset(-20)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


