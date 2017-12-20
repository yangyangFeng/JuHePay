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
    
    var forgetFirstStepAccountCell: APSendSMSCodeFormsCell = {
        let view = APSendSMSCodeFormsCell()
        view.inputRegx = .mobile
        view.sendSmsCodeButton.setTitle(_ : "获取验证码", for: .normal)
        view.textField.placeholder = "请输入注册手机号"
        return view
    }()
    
    var forgetFirstStepSmsCodeCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = .smsCode
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入短信验证码"
        return view
    }()
    
    var forgetFirstStepSubmitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交", for: .normal)
        return view
    }()

    //MARK: ------------- 生命周期
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.forgetFirstStepAccountCell.sendSmsCodeButton.isCounting = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注意：私有方法调用顺序 (系统配置->创建子视图->子视图布局->监听子视图回调->注册通知)
        forgetFirstStepCreateSubViews()
        forgetFirstStepLayoutSubViews()
        forgetFirstStepTargetCallBacks()
        forgetFirstStepRegisterObserve()
        APForgetViewController.forgetRequest.mobile = ""
        APForgetViewController.forgetRequest.smsCode = ""
    }
    
    //MARK: ------------- 私有方法
    
    private func forgetFirstStepCreateSubViews() {
        view.addSubview(forgetFirstStepAccountCell)
        view.addSubview(forgetFirstStepSmsCodeCell)
        view.addSubview(forgetFirstStepSubmitCell)
    }
    
    private func forgetFirstStepLayoutSubViews() {
        forgetFirstStepAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetFirstStepSmsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetFirstStepAccountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetFirstStepSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetFirstStepSmsCodeCell.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
    }
    
    private func forgetFirstStepTargetCallBacks() {
        
        weak var weakSelf = self
        
        forgetFirstStepAccountCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.mobile = value
        }
        
        forgetFirstStepSmsCodeCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.smsCode = value
        }
        
        forgetFirstStepAccountCell.sendSmsCodeBlock = { (key, value) in
            weakSelf?.forgetFirstStepAccountCell.sendSmsCodeButton.isCounting = true
        }
        
        forgetFirstStepSubmitCell.buttonBlock = { (key, value) in
            //验证手机号是否合法
            if !CPCheckAuthInputInfoTool.evaluatePhoneNumber(APForgetViewController.forgetRequest.mobile) {
                weakSelf?.view.makeToast("手机号输入错误，请重新填写")
                return
            }
            let LastStepVC: APForgetViewController = APForgetLastStepViewController()
            weakSelf?.navigationController?.pushViewController(LastStepVC, animated: true)
        }
    }
    
    private func forgetFirstStepRegisterObserve() {
        
        weak var weakSelf = self
        
        self.kvoController.observe(APForgetViewController.forgetRequest,
                                   keyPaths: ["mobile",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let forgetModel = object as! APForgetRequest
            if  forgetModel.mobile.characters.count >= 11 &&
                forgetModel.smsCode.characters.count >= 4 {
                weakSelf?.forgetFirstStepSubmitCell.isEnabled = true
            }
            else {
                weakSelf?.forgetFirstStepSubmitCell.isEnabled = false
            }
        }
    }
   

}








