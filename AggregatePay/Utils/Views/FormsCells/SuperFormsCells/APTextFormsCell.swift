//
//  CPLoginFormsView.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit

class APTextFormsCell: APBaseFormsCell, UITextFieldDelegate {

    lazy var textField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.font = UIFont.systemFont(ofSize: 14)
        view.setValue(UIFont.systemFont(ofSize: 36),
                      forKeyPath: "_placeholderLabel.font")
        view.setValue(UIColor.red,
                      forKeyPath: "_placeholderLabel.textColor")
        view.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        return view
    }()

    override init() {
        super.init()
        bottomLine.theme_backgroundColor = ["#f4f4f4"]
        addSubview(textField)
        textField.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
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
