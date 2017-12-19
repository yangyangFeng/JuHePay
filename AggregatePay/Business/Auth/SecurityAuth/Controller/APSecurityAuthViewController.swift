//
//  APSecurityAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSecurityAuthViewController: APAuthBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
    }
}

extension APSecurityAuthViewController {
    
    // MARK: -- UI
    fileprivate func layoutViews() {
        
        authHeadMessage.text = "结算银行卡为收款到账的银行卡，必须为储蓄卡。"
        
        let nameFormCell = APRealNameFormCell()
        let idCardFormCell = APIdCardNoFormCell()
        let creditCardFormCell = APBankCardNoFormCell()
        let phoneNumFormCell = APAuthPhoneNumFormCell()
        
        formCellView.addSubview(nameFormCell)
        formCellView.addSubview(idCardFormCell)
        formCellView.addSubview(creditCardFormCell)
        formCellView.addSubview(phoneNumFormCell)
        
        nameFormCell.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-2)
            make.height.equalTo(50)
        }
        idCardFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(nameFormCell.snp.bottom).offset(1)
            make.left.right.height.equalTo(nameFormCell)
        }
        creditCardFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(idCardFormCell.snp.bottom).offset(1)
            make.left.right.height.equalTo(idCardFormCell)
        }
        phoneNumFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(creditCardFormCell.snp.bottom)
            make.left.right.height.equalTo(creditCardFormCell)
        }
        formCellView.snp.remakeConstraints { (make) in
            make.top.equalTo(authHeadMessage.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(4 * 50 + 5)
        }
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(formCellView.snp.bottom)
        }
    }
}
