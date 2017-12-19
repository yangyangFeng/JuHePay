//
//  APPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPasswordFormsCell: APBaseFormsCell, UITextFieldDelegate {

    lazy var textField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.isSecureTextEntry = true
        view.clearButtonMode = .whileEditing
        view.font = UIFont.systemFont(ofSize: 14)
        view.keyboardType = UIKeyboardType.asciiCapable
        view.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        return view
    }()

    lazy var button: UIButton = {
        let view = UIButton()
        view.theme_setImage(["sys_eye_nor_icon"], forState: .normal)
        view.theme_setImage(["sys_eye_sel_icon"], forState: .selected)
        view.addTarget(self, action: #selector(clickEdit(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    override init() {
        super.init()
        bottomLine.theme_backgroundColor = ["#f4f4f4"]

        addSubview(button)
        addSubview(textField)

        button.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(30)
        }
        textField.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(button.snp.left)
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
    
    @objc func clickEdit(_ buttonParam: UIButton) {
        button.isSelected = !buttonParam.isSelected
        textField.isSecureTextEntry = !button.isSelected
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let text = textField.text! as NSString
        return limitTextCount(text: text, range: range, string: string)
    }

}
