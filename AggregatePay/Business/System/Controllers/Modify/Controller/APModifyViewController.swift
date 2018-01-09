//
//  APModifyViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APModifyViewController: APBaseViewController {

    let updatePasswordRequest: APUpdatePasswordRequest = APUpdatePasswordRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改密码"
        view.backgroundColor = UIColor.white
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
    
    //MARK: ---- lazy loading
    lazy var oldPasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请输入旧密码"
        view.textField.isSecureTextEntry = false
        view.textField.clearButtonMode = .never
        view.button.isHidden = true
        return view
    }()
    
    lazy var newPasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.clearButtonMode = .never
        view.textField.placeholder = "请输入新密码(6-16位字母、数字或下划线)"
        view.button.isHidden = true
        return view
    }()
    
    lazy var repeatPasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请再次输入新密码"
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交", for: .normal)
        return view
    }()
}

extension APModifyViewController {
    
    //MARK: ----- private
    private func  createSubviews() {

        view.addSubview(oldPasswordCell)
        view.addSubview(newPasswordCell)
        view.addSubview(repeatPasswordCell)
        view.addSubview(submitCell)
        
        oldPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(41)
        }
        
        newPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(oldPasswordCell.snp.bottom)
            make.left.right.height.equalTo(oldPasswordCell)
        }
        
        repeatPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(newPasswordCell.snp.bottom)
            make.left.right.height.equalTo(oldPasswordCell)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordCell.snp.bottom).offset(20)
            make.left.right.equalTo(oldPasswordCell)
            make.height.equalTo(41)
        }
    }
    
    private func registerCallBacks() {
        
        weak var weakSelf = self
        
        oldPasswordCell.textBlock = { (key, value) in
            weakSelf?.updatePasswordRequest.pwdOld = value
        }
        
        newPasswordCell.textBlock = { (key, value) in
            weakSelf?.updatePasswordRequest.pwd = value
        }
        
        repeatPasswordCell.textBlock = { (key, value) in
            weakSelf?.updatePasswordRequest.pwdConfirm = value
        }
        
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.updatePassword()
        }
    }
    
    private func registerObserve() {
        
        weak var weakSelf = self
        self.kvoController.observe(updatePasswordRequest,
                                   keyPaths: ["pwdOld",
                                              "pwd",
                                              "pwdConfirm"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let updatePasswordModel = object as! APUpdatePasswordRequest
            if  updatePasswordModel.pwdOld.count >= 6 &&
                updatePasswordModel.pwd.count >= 6 &&
                updatePasswordModel.pwdConfirm.count >= 6 {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
   
    private func updatePassword() {
        if !updatePasswordRequest.pwdOld.evaluate(regx: .password) {
            view.makeToast("旧密码输入错误")
            return
        }
        if !updatePasswordRequest.pwd.evaluate(regx: .password) {
            view.makeToast("密码格式不正确")
            return
        }
        if updatePasswordRequest.pwd != updatePasswordRequest.pwdConfirm{
            view.makeToast("再次输入密码不正确")
            return
        }
        updatePasswordRequest.userId = APUserDefaultCache.AP_get(key: .userId) as! String
        submitCell.loading(isLoading: true, isComplete: nil)
        APSystemHttpTool.updatePassword(paramReqeust: updatePasswordRequest, success: { (baseResp) in
            self.submitCell.loading(isLoading: false, isComplete: {
                self.modifySuccessShow {
                    APOutLoginTool.loginOut()
                }
            })
        }) { (errorMsg) in
            self.view.makeToast(errorMsg)
            self.submitCell.loading(isLoading: false, isComplete: nil)
        }
    }
    
    
}
