//
//  APPayEssentialCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APPayEssentialRightViewBlock = (_ param: Any) -> Void

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
    
    lazy var button: UIButton = {
        let view = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.setTitle("更换", for: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.addTarget(self, action: #selector(clickButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    let textCell: APTextFormsCell = APTextFormsCell()
    
    var payEssentialRightViewBlock: APPayEssentialRightViewBlock?

    override init() {
        super.init()
        
        backgroundColor = UIColor.white
        
        textCell.bottomLine.backgroundColor = UIColor.clear
        textCell.textField.keyboardType = UIKeyboardType.numberPad
        textCell.textField.rightView = button
        textCell.textField.rightViewMode = .never
        
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
    
    @objc func clickButton(_ button: UIButton) {
        textCell.textField.text = ""
        textCell.textField.becomeFirstResponder()
        payEssentialRightViewBlock?(button)
    }
}



