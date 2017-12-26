//
//  APSecurityAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSecurityAuthViewController: APAuthBaseViewController {

    let nameFormCell = APRealNameFormCell()
    let idCardFormCell = APIdCardNoFormCell()
    let creditCardFormCell = APCreditCardFormCell()
    let phoneNumFormCell = APAuthPhoneNumFormCell()
    
    lazy var authParam: APSecurityAuthRequest = {
        let authParam = APSecurityAuthRequest()
        return authParam
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
        userInputCallBacks()
    }
    
    func userInputCallBacks() {
        weak var weakSelf = self
        nameFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.name = value
        }
        idCardFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.identityCard = value
        }
        creditCardFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.accountNo = value
        }
        phoneNumFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.photoNumber = value
        }
    }
    
    override func commit() {
        if let _ = processView() {
            let navi = authNavigation()
            navi?.finishAuths?()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension APSecurityAuthViewController {
    
    // MARK: -- UI
    fileprivate func layoutViews() {
        
        authHeadMessage.text = "为保障您的支付安全,请进行信用卡认证。"
        
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
