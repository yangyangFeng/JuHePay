//
//  APUnionBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionBaseViewController: APUnionPayBaseViewController {
    
    var payPlaceTitle: String?  // 显示渠道标题
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "输入支付要素"
        ap_initCreateSubviews()
        ap_payEssentialTargetCallBacks()
        ap_payEssentialRegisterObserve()
        
        headerView.amountLabel.text = totalAmount
        headerView.payEssentialTextLabel.text = payPlaceTitle
    }
    
    //MARK: - public
    func ap_initCreateSubviews() {
        view.addSubview(headerView)
        view.addSubview(toolBarView)
        headerView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(120)
        }
        toolBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(43)
        }
    }
    
    func ap_payEssentialTargetCallBacks() {
        weak var weakSelf = self
        smsCodeCell.smsCodeCell.sendSmsCodeBlock = { (key, value) in
            weakSelf?.ap_httpSendSmsCode()
        }
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.ap_httpSubmit()
        }
        toolBarView.selectCreditCardBlock = {(param) in
            let creditCardVC = APSelectCreditCardViewController()
            weakSelf?.navigationController?.pushViewController(creditCardVC, animated: true)
        }
    }
    
    func ap_payEssentialRegisterObserve() {
        
    }
    func ap_httpSendSmsCode() {}
    
    func ap_httpSubmit() {}
    
    //MARK: - Lazy Loading
    lazy var headerView: APPayElementHeaderView = {
        let view = APPayElementHeaderView()
        return view
    }()
    
    lazy var toolBarView: APPayElementToolBarView = {
        let view = APPayElementToolBarView()
        view.selectCreditCardButton.isHidden = true
        return view
    }()
    
    //持卡人姓名
    lazy var realNameCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "持卡人姓名"
        view.textCell.textField.placeholder = "持卡人姓名"
        view.textCell.textField.isUserInteractionEnabled = false
        view.textCell.textField.keyboardType = UIKeyboardType.default
        return view
    }()
    
    //信用卡卡号//6230 5820 0002 6379 795
    lazy var bankCardNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "信用卡卡号"
        view.textCell.textField.placeholder = "请输入信用卡号"
        view.textCell.inputRegx = .bankCard
        view.textCell.textField.text = "6230582000026379795"
        return view
    }()
    
    //CVN2
    lazy var cvnNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "CVN2"
        view.textCell.textField.placeholder = "信用卡背面后三位数字"
        view.textCell.inputRegx = .cvn2
        return view
    }()
    
    //有效期
    lazy var validityDateCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "有效期"        
        view.textCell.inputRegx = .smsCode
        view.textCell.textField.placeholder = "请输入有效期，格式：02/12"
        return view
    }()
    
    //预留手机号
    lazy var phoneNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "预留手机号"
        view.textCell.textField.placeholder = "请输入银行预留手机号"
        view.textCell.inputRegx = .mobile
        view.textCell.textField.text = "17310070423"
        return view
    }()
    
    //验证码
    lazy var smsCodeCell: APPayElementSmsCodeCell = {
        let view = APPayElementSmsCodeCell()
        view.titleLabel.text = "验证码"
        view.smsCodeCell.textField.placeholder = "请填写验证码"
        view.smsCodeCell.inputRegx = .quickSmsCode
        return view
    }()
    
    //提交
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交订单", for: .normal)
        return view
    }()

    
}
