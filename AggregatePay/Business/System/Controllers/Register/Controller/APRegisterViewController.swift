//
//  APRegisterViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 注册
 *一: 1、手机号：必须为11位，第一位必须为1（此处需要做正则校验）
      2、若输入错误toast提示：手机号输入格式不正确
 *二: 1、短信验证码：四位数字
      2、验证码错误提示：验证码输入不正确
 *三: 1、密码：由6-16位字母、数字或下划线组成。密码输入不能超过16位。
 *    2、若密码设置有误提示：密码格式不正确
 *四: 邀请码：输入错误提示：邀请码不正确
 *五: 必须全部填写完且勾选了用户协议，注册按钮才会亮起，否则置灰不可点击。
 */
class APRegisterViewController: APSystemBaseViewController {
    
    //MARK: ------------- 全局属性
    let registerRequest: APRegisterRequest = APRegisterRequest()
    
    lazy var accountCell: APSendSMSCodeFormsCell = {
        let view = APSendSMSCodeFormsCell()
        view.inputRegx = .mobile
        view.sendSmsCodeButton.setTitle(_ : "发送短信验证码", for: .normal)
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入11位手机号码"
        return view
    }()
    
    lazy var smsCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = .smsCode
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入短信验证码"
        return view
    }()
    
    lazy var passwordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请输入密码(6-16位字母、数字或下划线)"
        return view
    }()
    
    lazy var inviteCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = .inviteCode
        view.textField.keyboardType = UIKeyboardType.asciiCapable
        view.textField.placeholder = "请输入邀请码"
        return view
    }()
    
    lazy var agreedCell: APSelectBoxFormsCell = {
        let view = APSelectBoxFormsCell()
        view.button.setTitle(_ : " 我已阅读并接受《XXX用户协议》", for: .normal)
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("下一步", for: .normal)
        return view
    }()
    
    //MARK: ------------- 生命周期
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.accountCell.sendSmsCodeButton.isCounting = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商户注册"
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
    
    private func createSubviews() {
        
        view.addSubview(accountCell)
        view.addSubview(smsCodeCell)
        view.addSubview(passwordCell)
        view.addSubview(inviteCodeCell)
        view.addSubview(agreedCell)
        view.addSubview(submitCell)
        
        accountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset )
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        smsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(accountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        passwordCell.snp.makeConstraints { (make) in
            make.top.equalTo(smsCodeCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        inviteCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(passwordCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        agreedCell.snp.makeConstraints { (make) in
            make.top.equalTo(inviteCodeCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.top.equalTo(agreedCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
    }
    
    private func registerCallBacks() {
        
        weak var weakSelf = self
        
        accountCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.mobile = value
        }
        
        smsCodeCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.smsCode = value
        }
        
        passwordCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.password = value
        }
        
        inviteCodeCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.inviteCode = value
        }
        
        agreedCell.buttonBlock = { (key, value) in
            let button: UIButton = value as! UIButton
            weakSelf?.registerRequest.isAgreed = button.isSelected
        }
        
        accountCell.sendSmsCodeBlock = { (key, value) in
            weakSelf?.accountCell.sendSmsCodeButton.isCounting = true
        }
        
        submitCell.buttonBlock = { (key, value) in
            let isEvaluate: Bool = (weakSelf?.evaluate())!
            if isEvaluate {
                weakSelf?.startRegisterHttpRequest()
            }
        }
    }
    
    private func registerObserve() {
        
        weak var weakSelf = self
        
        self.kvoController.observe(self.registerRequest,
                                   keyPaths: ["mobile",
                                              "password",
                                              "inviteCode",
                                              "smsCode",
                                              "isAgreed"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let registerModel = object as! APRegisterRequest
            if (registerModel.mobile.characters.count >= 11 &&
                registerModel.password.characters.count >= 6 &&
                registerModel.inviteCode.characters.count >= 6 &&
                registerModel.smsCode.characters.count >= 4 &&
                registerModel.isAgreed) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func evaluate() -> Bool {

        if !self.registerRequest.mobile.evaluate(regx: .mobile) {
            self.view.makeToast("手机号输入格式不正确")
            return false
        }
        
        if !self.registerRequest.password.evaluate(regx: .password) {
            self.view.makeToast("请输入6至16位密码")
            return false
        }
        return true
    }
    
    private func startRegisterHttpRequest() {
        self.navigationController?.pushViewController(APRegisterSuccessViewController())
    }

  
}





















