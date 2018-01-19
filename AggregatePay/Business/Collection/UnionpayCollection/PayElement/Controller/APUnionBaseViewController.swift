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
        
        view.insertSubview(scrollView, at: 0)
        scrollView.addSubview(containerView)
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }

        containerView.addSubview(headerView)
        containerView.addSubview(toolBarView)
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(120)
        }
        toolBarView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview()
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.clipsToBounds = false
        scrollView.backgroundColor = UIColor.clear
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
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
    
    //信用卡卡号
    lazy var bankCardNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "信用卡卡号"
        view.textCell.textField.placeholder = "请输入信用卡号"
        view.textCell.inputRegx = .bankCard
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
        view.textCell.textField.placeholder = "请输入有效期,格式：MMYY"
        return view
    }()
    
    //预留手机号
    lazy var phoneNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "预留手机号"
        view.textCell.textField.placeholder = "请输入银行预留手机号"
        view.textCell.inputRegx = .mobile
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
    
    //用户协议
    lazy var agreedCell: APSelectBoxFormsCell = {
        let view = APSelectBoxFormsCell()
        view.button.setTitle(_ : " 我已阅读并接受", for: .normal)
        view.extButton.setTitle(_ : "《银联用户服务协议》", for: .normal)
        return view
    }()
    
    //提交
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交订单", for: .normal)
        return view
    }()

    
}
