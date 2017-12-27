//
//  APModifyViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 修改密码
 */
class APForgetLastStepViewController: APSystemBaseViewController {
    
    
    let resetPasswordRequest = APResetPasswordRequest()

    //MARK: ----- life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        createSubviews()
        registerCallBacks()
        registerObserve()
    }

    //MARK: ---- lazy loading
    lazy var passwordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请设置密码(6-16位字母、数字或下划线)"
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("下一步", for: .normal)
        return view
    }()
}

//MARK: --------------- Extension

extension APForgetLastStepViewController {
    
    //MARK: ---- private
    
    private func createSubviews() {
        
        view.addSubview(passwordCell)
        view.addSubview(submitCell)
        
        passwordCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.top.equalTo(passwordCell.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(41)
        }
    }
    
    private func registerCallBacks() {
        
        weak var weakSelf = self
        passwordCell.textBlock = { (key, value) in
            weakSelf?.resetPasswordRequest.pwd = value
            weakSelf?.resetPasswordRequest.pwdConfirm = value
        }
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.forgetPassword()
        }
    }
    
    private func registerObserve() {
        
        weak var weakSelf = self
        self.kvoController.observe(resetPasswordRequest,
                                   keyPaths: ["pwd"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let resetPasswordModel = object as! APResetPasswordRequest
            if  resetPasswordModel.pwd.characters.count >= 6{
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func forgetPassword() {
        
        if !resetPasswordRequest.pwd.evaluate(regx: .password) {
            self.view.makeToast("密码格式错误")
            return
        }
        submitCell.loading(isLoading: true, isComplete: nil)
        APSystemHttpTool.resetPassword(paramReqeust: resetPasswordRequest, success: { (baseReps) in
            self.submitCell.loading(isLoading: false, isComplete: {
                self.forgetSuccessShow {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }) { (errorMsg) in
            self.submitCell.loading(isLoading: false, isComplete: nil)
            self.view.makeToast(errorMsg)
        }
        
    }
}






