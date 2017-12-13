//
//  APPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPasswordFormsCell: APFormsCell {

    var textField: UITextField = UITextField()
    //点击可切换显示/隐藏密码，默认隐藏。
    let edit: UIButton = UIButton()
    
    override init() {
        super.init()
    
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.keyboardType = UIKeyboardType.asciiCapable
        textField.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        
        edit.theme_setImage(["sys_eye_nor_icon"], forState: .normal)
        edit.theme_setImage(["sys_eye_sel_icon"], forState: .selected)
        
        addSubview(edit)
        addSubview(textField)

        edit.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(30)
        }
        textField.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(edit.snp.left)
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
    
    @objc func clickEdit(_ button: UIButton) {
        textField.isSecureTextEntry = button.isSelected
    }

}
