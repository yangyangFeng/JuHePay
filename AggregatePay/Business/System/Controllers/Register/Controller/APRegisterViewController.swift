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
    
    lazy var registerAccountCell: APSendSMSCodeFormsCell = {
        let view = APSendSMSCodeFormsCell()
        view.inputRegx = "^1[0-9]{0,10}$"
        view.sendSmsCodeButton.setTitle(_ : "发送短信验证码", for: .normal)
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入11位手机号码"
        return view
    }()
    
    lazy var registerSmsCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = "^[0-9]{0,4}$"
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入短信验证码"
        return view
    }()
    
    lazy var registerPasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = "^[A-Za-z0-9-_]{0,20}$"
        view.textField.placeholder = "请输入密码(6-16位字母、数字或下划线)"
        return view
    }()
    
    lazy var registerInviteCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = "^[A-Za-z0-9-_]{0,6}$"
        view.textField.keyboardType = UIKeyboardType.asciiCapable
        view.textField.placeholder = "请输入邀请码"
        return view
    }()
    
    lazy var registerAgreedCell: APSelectBoxFormsCell = {
        let view = APSelectBoxFormsCell()
        view.button.setTitle(_ : " 我已阅读并接受《XXX用户协议》", for: .normal)
        return view
    }()
    
    lazy var registerSubmitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("下一步", for: .normal)
        return view
    }()
    
    //MARK: ------------- 生命周期

    override func viewDidLoad() {
        super.viewDidLoad()
        //注意：私有方法调用顺序 (系统配置->创建子视图->子视图布局->监听子视图回调->注册通知)
        registerSystemConfig()
        registerCreateSubViews()
        registerLayoutSubViews()
        registerTargetCallBacks()
        registerRegisterObserve()
    }
    
    //MARK: ------------- 私有方法
    
    private func registerSystemConfig() {
        self.title = "商户注册"
        
    }
    
    private func registerCreateSubViews() {
        
        view.addSubview(registerAccountCell)
        view.addSubview(registerSmsCodeCell)
        view.addSubview(registerPasswordCell)
        view.addSubview(registerInviteCodeCell)
        view.addSubview(registerAgreedCell)
        view.addSubview(registerSubmitCell)
    }
    
    private func registerLayoutSubViews() {
        
        registerAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset )
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerSmsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerAccountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerSmsCodeCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerInviteCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerPasswordCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerAgreedCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerInviteCodeCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerAgreedCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
    }
    
    private func registerTargetCallBacks() {
        
        weak var weakSelf = self
        
        registerAccountCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.mobile = value
        }
        
        registerSmsCodeCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.smsCode = value
        }
        
        registerPasswordCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.password = value
        }
        
        registerInviteCodeCell.textBlock = { (key, value) in
            weakSelf?.registerRequest.inviteCode = value
        }
        
        registerAgreedCell.buttonBlock = { (key, value) in
            let button: UIButton = value as! UIButton
            weakSelf?.registerRequest.isAgreed = button.isSelected
        }
        
        registerSubmitCell.buttonBlock = { (key, value) in
            
        }
    }
    
    private func registerRegisterObserve() {
        
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
                weakSelf?.registerSubmitCell.isEnabled = true
            }
            else {
                weakSelf?.registerSubmitCell.isEnabled = false
            }
        }
    }
}





















