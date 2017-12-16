//
//  APPayEssentialSmsCodeCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

//MARK ----  APPayEssentialSmsCodeCell

/**
 * 输入支付要素子视图（带标题、输入框、发送验证码按钮的cell）
 */
class APPayEssentialSmsCodeCell: APBaseFormsCell {

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        return view
    }()
    
    var smsCodeCell: APSendSMSCodeFormsCell = APSendSMSCodeFormsCell()
    
    override init() {
        super.init()
        
        backgroundColor = UIColor.white
        smsCodeCell.bottomLine.backgroundColor = UIColor.clear
        
        addSubview(titleLabel)
        addSubview(smsCodeCell)
        
        smsCodeCell.sendSmsCodeButton.setTitle(_ : "获取验证码", for: .normal)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(80)
        }
        
        smsCodeCell.snp.makeConstraints { (maker) in
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

