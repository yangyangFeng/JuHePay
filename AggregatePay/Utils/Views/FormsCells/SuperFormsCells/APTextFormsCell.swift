//
//  CPLoginFormsView.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//


/**
 *  样式：
 *  [图标|输入框]
 */
import UIKit

class APTextFormsCell: APFormsCell {

    var textField: UITextField = UITextField()

    override init() {
        super.init()
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
    
    

}
