//
//  CPCodeFormsCell.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//
/**
 *  样式：
 *  [图标|输入框|发送验证码]
 */
import UIKit

class APSendSMSCodeFormsCell: APFormsCell {

    var textField: UITextField = UITextField()
    var sendSmsCodeButton: UIButton = UIButton()
    
    override init() {
        super.init()
        
        sendSmsCodeButton.contentHorizontalAlignment = .right
        sendSmsCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sendSmsCodeButton.theme_setTitleColor(["#d09326"], forState: .normal)
        sendSmsCodeButton.theme_setTitleColor(["#d09326"], forState: .selected)
        
        textField.placeholder = "请输入11位手机号码"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.keyboardType = UIKeyboardType.numberPad
        textField.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        
        addSubview(textField)
        addSubview(sendSmsCodeButton)
        
        sendSmsCodeButton.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(100)
        }
        textField.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(sendSmsCodeButton.snp.left)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textChange(_ textField:UITextField) {
        textBlock?(identify, textField.text!)
    }

}
