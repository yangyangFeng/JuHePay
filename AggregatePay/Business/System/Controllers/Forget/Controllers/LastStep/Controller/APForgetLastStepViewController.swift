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
class APForgetLastStepViewController: APForgetViewController {
    
    //MARK: ------------- 全局属性
    let passwordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请设置密码(6-16位字母、数字或下划线)"
        return view
    }()
    
    let submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("下一步", for: .normal)
        return view
    }()
    
    //MARK: ------------- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APForgetViewController.forgetRequest.password = ""
        prompt.text = ""
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
    
    //MARK: ------------- 私有方法
    
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
            APForgetViewController.forgetRequest.password = value
        }
        
        submitCell.buttonBlock = { (key, value) in
            let isEvaluate: Bool = (weakSelf?.evaluate())!
            if isEvaluate {
                weakSelf?.startForgetHttpRequest()
            }
        }
    }
    
    private func registerObserve() {
       
        weak var weakSelf = self
        
        self.kvoController.observe(APForgetViewController.forgetRequest,
                                   keyPaths: ["mobile",
                                              "password",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let forgetModel = object as! APForgetRequest
            if  forgetModel.mobile.characters.count >= 11 &&
                forgetModel.password.characters.count >= 6 &&
                forgetModel.smsCode.characters.count >= 4 {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func evaluate() -> Bool {
       
        if !APForgetViewController.forgetRequest.password.evaluate(regx: .password) {
            self.view.makeToast("密码格式错误")
            return false
        }
        return true
    }
    
    private func startForgetHttpRequest() {
       
        forgetSuccessShow {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
   

}







