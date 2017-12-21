//
//  APForgetViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 忘记密码
 */
class APForgetFirstStepViewController: APForgetViewController {
    
    //MARK: ------------- 全局属性
    
    var accountCell: APSendSMSCodeFormsCell = {
        let view = APSendSMSCodeFormsCell()
        view.inputRegx = .mobile
        view.sendSmsCodeButton.setTitle(_ : "获取验证码", for: .normal)
        view.textField.placeholder = "请输入注册手机号"
        return view
    }()
    
    var smsCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = .smsCode
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入短信验证码"
        return view
    }()
    
    var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交", for: .normal)
        return view
    }()

    //MARK: ------------- 生命周期
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        accountCell.sendSmsCodeButton.isCounting = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APForgetViewController.forgetRequest.mobile = ""
        APForgetViewController.forgetRequest.smsCode = ""
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
    
    //MARK: ------------- 私有方法
    
    private func createSubviews() {
        
        view.addSubview(accountCell)
        view.addSubview(smsCodeCell)
        view.addSubview(submitCell)
        
        accountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
        
        smsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(accountCell.snp.bottom)
            make.left.right.height.equalTo(accountCell)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.top.equalTo(smsCodeCell.snp.bottom).offset(40)
            make.left.right.equalTo(accountCell)
            make.height.equalTo(41)
        }
    }
    private func registerCallBacks() {
        weak var weakSelf = self
        
        accountCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.mobile = value
        }
        
        smsCodeCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.smsCode = value
        }
        
        accountCell.sendSmsCodeBlock = { (key, value) in
            weakSelf?.startSendSmsCodeHttpRequest()
        }
        
        submitCell.buttonBlock = { (key, value) in
            let isEvaluate: Bool = (weakSelf?.evaluate())!
            if isEvaluate {
                let LastStepVC: APForgetViewController = APForgetLastStepViewController()
                weakSelf?.navigationController?.pushViewController(LastStepVC, animated: true)
            }
        }
    }
    
    private func registerObserve() {
        
        weak var weakSelf = self
        
        self.kvoController.observe(APForgetViewController.forgetRequest,
                                   keyPaths: ["mobile",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let forgetModel = object as! APForgetRequest
            if  forgetModel.mobile.characters.count >= 11 &&
                forgetModel.smsCode.characters.count >= 4 {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func evaluate() -> Bool {
        
        if !APForgetViewController.forgetRequest.mobile.evaluate(regx: .mobile) {
            self.view.makeToast("手机号输入错误，请重新填写")
            return false
        }
        return true
    }
    
    private func startSendSmsCodeHttpRequest() {
       accountCell.sendSmsCodeButton.isCounting = true
    }

}








