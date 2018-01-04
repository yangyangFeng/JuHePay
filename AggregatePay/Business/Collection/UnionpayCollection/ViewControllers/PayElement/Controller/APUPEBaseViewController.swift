//
//  APUPEBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUPEBaseViewController: APUnionPayBaseViewController {

    var payPlaceTitle: String?
    
    //如果传过来的卡详情是nil则表示用户未开通过银联快捷收款
    var quickCardDetail: APQueryQuickPayCardDetail?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endSendSmsCode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "输入支付要素"
        headerView.amountLabel.text = totalAmount
        headerView.payEssentialTextLabel.text = payPlaceTitle
        if quickCardDetail == nil {
            toolBarView.selectCreditCardButton.isHidden = true
        }
        else {
            toolBarView.selectCreditCardButton.isHidden = false
            realNameCell.textCell.textField.text = quickCardDetail?.realName
            bankCardNoCell.textCell.textField.text = quickCardDetail?.cardNo
        }
        initCreateSubviews()
        ap_payEssentialTargetCallBacks()
        ap_payEssentialRegisterObserve()
        
    }
    
    //MARK: - public
    func ap_httpSendSmsCode() {}
    func ap_httpSubmit() {}
    func ap_payEssentialTargetCallBacks() {
        weak var weakSelf = self
        smsCodeCell.smsCodeCell.sendSmsCodeBlock = { (key, value) in
            weakSelf?.ap_httpSendSmsCode()
        }
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.ap_httpSubmit()
        }
    }
    func ap_payEssentialRegisterObserve() {}

    //MARK: - lazy loading
    lazy var headerView: APPayElementHeaderView = {
        let view = APPayElementHeaderView()
        return view
    }()
    
    lazy var toolBarView: APPayElementToolBarView = {
        let view = APPayElementToolBarView()
        return view
    }()
    
    //持卡人姓名
    lazy var realNameCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "持卡人姓名"
        view.textCell.textField.placeholder = "持卡人姓名"
        view.textCell.textField.keyboardType = UIKeyboardType.default
        view.textCell.textField.text = "徐艺达"
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
        view.smsCodeCell.inputRegx = .smsCode
        return view
    }()
    
    //提交
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交订单", for: .normal)
        return view
    }()

}

//MARK: ---------  APUPEBaseViewController --- Extension (私有方法)

extension APUPEBaseViewController {
    
    private func initCreateSubviews() {
        
        view.addSubview(headerView)
        view.addSubview(toolBarView)
        view.addSubview(realNameCell)
        view.addSubview(bankCardNoCell)
        view.addSubview(cvnNoCell)
        view.addSubview(validityDateCell)
        view.addSubview(phoneNoCell)
        view.addSubview(smsCodeCell)
        view.addSubview(submitCell)
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        toolBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(43)
        }
        
        realNameCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(toolBarView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        bankCardNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(realNameCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        cvnNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bankCardNoCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        validityDateCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cvnNoCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        phoneNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(validityDateCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        smsCodeCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneNoCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        submitCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(smsCodeCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
    }
}

//MARK: ---------  APUPEBaseViewController --- Extension (网络相关方法)

extension APUPEBaseViewController {
    
    func waitSendSmsCode() {
        smsCodeCell.smsCodeCell.sendSmsCodeButton.countingStatus = .wait
    }
    
    func startSendSmsCode() {
        smsCodeCell.smsCodeCell.sendSmsCodeButton.countingStatus = .start
    }
    
    func endSendSmsCode() {
        smsCodeCell.smsCodeCell.sendSmsCodeButton.countingStatus = .end
    }
}
