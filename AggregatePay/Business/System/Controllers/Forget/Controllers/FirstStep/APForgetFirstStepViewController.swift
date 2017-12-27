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
class APForgetFirstStepViewController: APSystemBaseViewController {
    
    
    
    let checkMessageRequest = APCheckMessageRequest()
    
    //MARK: ------------- 生命周期
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        accountCell.sendSmsCodeButton.countingStatus = .end
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
    
    //MARK: ----- lazy loading
    
    lazy var prompt: UILabel = {
        let view = UILabel()
        view.theme_textColor = ["#d09326"]
        view.theme_backgroundColor = ["#fff4d9"]
        view.font = UIFont.systemFont(ofSize: 10)
        view.text = "    为了保障您的账户安全，请输入注册手机号码进行验证。"
        return view
    }()
    
    lazy var accountCell: APSendSMSCodeFormsCell = {
        let view = APSendSMSCodeFormsCell()
        view.inputRegx = .mobile
        view.sendSmsCodeButton.setTitle(_ : "获取验证码", for: .normal)
        view.textField.placeholder = "请输入注册手机号"
        return view
    }()
    
    lazy var smsCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = .smsCode
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入短信验证码"
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交", for: .normal)
        return view
    }()

}

//MARK: --------------- Extension

extension APForgetFirstStepViewController {
    
    //MARK: ---- private
    
    private func createSubviews() {
        
        view.addSubview(prompt)
        view.addSubview(accountCell)
        view.addSubview(smsCodeCell)
        view.addSubview(submitCell)
        
        
        prompt.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(25)
        }
        
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
            weakSelf?.checkMessageRequest.mobileNo = value
        }
        
        smsCodeCell.textBlock = { (key, value) in
            weakSelf?.checkMessageRequest.idCode = value
        }
        
        accountCell.sendSmsCodeBlock = { (key, value) in
            weakSelf?.sendMessage()
        }
        
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.checkMessage()
        }
    }
    
    private func registerObserve() {
        weak var weakSelf = self
        self.kvoController.observe(checkMessageRequest,
                                   keyPaths: ["mobileNo",
                                              "idCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let checkMessageModel = object as! APCheckMessageRequest
            if  checkMessageModel.mobileNo.characters.count >= 11 &&
                checkMessageModel.idCode.characters.count >= 4 {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func evaluate() -> Bool {
        if  checkMessageRequest.mobileNo.count <= 0 {
            view.makeToast("请输入手机号")
            return false
        }
        if !checkMessageRequest.mobileNo.evaluate(regx: .mobile) {
            view.makeToast("手机号输入格式不正确")
            return false
        }
        return true
    }
    
    private func sendMessage() {
        if !evaluate() {
            return
        }
        let sendMessageReq = APSendMessageReq()
        sendMessageReq.mobileNo = checkMessageRequest.mobileNo
        sendMessageReq.businessType = "2"
        accountCell.sendSmsCodeButton.countingStatus = .wait
        APSystemHttpTool.sendMessage(paramReqeust: sendMessageReq, success: { (baseResp) in
            self.view.makeToast(baseResp.respMsg)
            self.accountCell.sendSmsCodeButton.countingStatus = .start
        }) { (errorMsg) in
            self.view.makeToast(errorMsg)
            self.accountCell.sendSmsCodeButton.countingStatus = .end
        }
    }
    
    private func checkMessage() {
        if !evaluate() {
            return
        }
        submitCell.loading(isLoading: true, isComplete: nil)
        APSystemHttpTool.checkMessage(paramReqeust: checkMessageRequest, success: { (baseResp) in
            self.submitCell.loading(isLoading: false, isComplete: { () in
                let lastStepVC: APForgetLastStepViewController = APForgetLastStepViewController()
                lastStepVC.resetPasswordRequest.mobileNo = self.checkMessageRequest.mobileNo
                self.navigationController?.pushViewController(lastStepVC, animated: true)
            })
        }) { (errorMsg) in
            self.submitCell.loading(isLoading: false, isComplete: nil)
            self.view.makeToast(errorMsg)
        }
    }
    
}








