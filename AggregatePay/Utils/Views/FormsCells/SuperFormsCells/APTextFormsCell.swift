//
//  CPLoginFormsView.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit

class APTextFormsCell: APFormsCell, UITextFieldDelegate {

    var textField: UITextField = UITextField()

    override init() {
        super.init()
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
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
