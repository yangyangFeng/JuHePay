//
//  APPayEssentialViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 银联快捷支付要素
 */
class APPayElementViewController: APBaseViewController {

    let cell_h = 43
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注意：私有方法调用顺序 (系统配置->创建子视图->子视图布局->监听子视图回调->注册通知)
        payEssentialSystemConfig()
        payEssentialCreateSubViews()
        payEssentialLayoutSubViews()
        payEssentialTargetCallBacks()
        payEssentialRegisterObserve()
    }
    
    private func payEssentialSystemConfig(){
        title = "输入支付要素"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.backgroundColor = UIColor.groupTableViewBackground
        
    }
    private func payEssentialCreateSubViews() {
        view.addSubview(headerView)
        view.addSubview(toolBarView)
        view.addSubview(bankCardNoCell)
        view.addSubview(cvnNoCell)
        view.addSubview(validityDateCell)
        view.addSubview(phoneNoCell)
        view.addSubview(smsCodeCell)
        view.addSubview(submitCell)
    }
    
    private func payEssentialLayoutSubViews() {
        headerView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        
        toolBarView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cell_h)
        }
        
        bankCardNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(toolBarView.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cell_h)
        }
        
        cvnNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bankCardNoCell.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cell_h)
        }
        
        validityDateCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cvnNoCell.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cell_h)
        }
        
        phoneNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(validityDateCell.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cell_h)
        }
        
        smsCodeCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneNoCell.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cell_h)
        }
        
        submitCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(smsCodeCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
    }
    
    private func payEssentialTargetCallBacks() {
        
        weak var weakSelf = self
        
        toolBarView.selectCreditCardBlock = { (param) in
            weakSelf?.navigationController?.pushViewController(APSelectCreditCardViewController(), animated: true)
        }
        
        bankCardNoCell.textCell.textBlock = { (key, value) in
            
        }
        
        cvnNoCell.textCell.textBlock = { (key, value) in
            
        }
        
        validityDateCell.textCell.textBlock = { (key, value) in
            
        }
        
        phoneNoCell.textCell.textBlock = { (key, value) in
            
        }
        
        smsCodeCell.smsCodeCell.textBlock = { (key, value) in
            
        }
        
        submitCell.buttonBlock = { (key, value) in
            let successVC = APBaseNavigationViewController(rootViewController: APCollectionSuccessViewController())
            weakSelf?.present(successVC, animated: true, completion: nil);
        }
    }
    
    private func payEssentialRegisterObserve() {
//        weak var weakSelf = self
//        self.kvoController.observe(self.loginRequest,
//                                   keyPaths: [""],
//                                   options: [.new, .initial])
//        { (observer, object, change) in
//            let loginModel = object as! APLoginRequest
//            if  loginModel.mobile.characters.count >= 11 &&
//                loginModel.password.characters.count >= 6{
//                weakSelf?.submitCell.isEnabled = true
//            }
//            else {
//                weakSelf?.submitCell.isEnabled = false
//            }
//        }
    }
    
    
    //头信息
    lazy var headerView: APPayElementHeaderView = {
        let view = APPayElementHeaderView()
        return view
    }()
    
    lazy var toolBarView: APPayElementToolBarView = {
        let view = APPayElementToolBarView()
        return view
    }()
    
    //信用卡卡号
    lazy var bankCardNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "信用卡卡号"
        view.textCell.textField.placeholder = "请输入信用卡号"
        view.textCell.inputRegx = "^\\d{0,24}$"        
        return view
    }()

    //CVN2
    lazy var cvnNoCell: APPayElementTextCell = {
        let view = APPayElementTextCell()
        view.titleLabel.text = "CVN2"
        view.textCell.textField.placeholder = "信用卡背面后三位数字"
        view.textCell.inputRegx = "^[0-9]{0,3}$"
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
        view.textCell.inputRegx = "^1[0-9]{0,10}$"
        return view
    }()
    
    //验证码
    lazy var smsCodeCell: APPayElementSmsCodeCell = {
        let view = APPayElementSmsCodeCell()
        view.titleLabel.text = "验证码"
        view.smsCodeCell.textField.placeholder = "请填写验证码"
        view.smsCodeCell.inputRegx = "^[0-9]{0,4}$"
        return view
    }()
    
    //提交
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交订单", for: .normal)
        return view
    }()

}
