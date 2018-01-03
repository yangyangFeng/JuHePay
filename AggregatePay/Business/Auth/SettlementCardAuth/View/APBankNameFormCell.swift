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
    let label = UILabel()
    
    
    var text: String? {
        didSet {
            label.textColor = UIColor.init(hex6: 0x484848)
            label.text = text
            textBlock?(identify, text!)
        }
    }
    
    override var enable: Bool {
        didSet {
            label.isUserInteractionEnabled = enable
        }
    }
    
    override init() {
        super.init()
        titleLabel.text = "开户行"
        textField.isEnabled = false

        label.text = "请选择开户银行"
        label.textColor = UIColor.init(hex6: 0x999999)
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(taped))
        label.addGestureRecognizer(tap)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
            make.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func taped() {
        delegate?.bankNameFormCellTaped()
    }
}
