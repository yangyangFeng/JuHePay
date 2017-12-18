//
//  CPCodeFormsCell.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit

class APSendSMSCodeFormsCell: APBaseFormsCell, UITextFieldDelegate {

    lazy var textField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.placeholder = "请输入11位手机号码"
        view.font = UIFont.systemFont(ofSize: 14)
        view.keyboardType = UIKeyboardType.numberPad
        view.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        return view
    }()
    
    lazy var sendSmsCodeButton: UIButton = {
        let view = UIButton()
        view.contentHorizontalAlignment = .right
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .selected)
        return view
    }()
    
    override init() {
        super.init()
        bottomLine.theme_backgroundColor = ["#f4f4f4"]
        
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

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        return limitTextCount(text: text, range: range, string: string)
    }
}
