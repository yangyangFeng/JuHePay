//
//  APBankNameFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

public protocol APBankNameFormCellDelegate: NSObjectProtocol {
    func bankNameFormCellTaped()
}

class APBankNameFormCell: APAuthBaseTextFormCell {
    
    public weak var delegate: APBankNameFormCellDelegate?
    let button = UIButton()
    
    var text: String? {
        didSet {
            button.setTitleColor(UIColor.init(hex6: 0x484848), for: .normal)
            button.setTitle(text, for: .normal)
            textBlock?(identify, text!)
        }
    }
    
    override init() {
        super.init()
        titleLabel.text = "开户行"
        textField.isEnabled = false

        button.setTitle("请选择开户银行", for: .normal)
        button.setTitleColor(UIColor.init(hex6: 0x999999), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
//        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(taped), for: UIControlEvents.touchUpInside)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -170, 0, 0)
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(textField)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func taped() {
        delegate?.bankNameFormCellTaped()
    }
}
