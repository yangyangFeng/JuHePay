//
//  APModifyViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APModifyViewController: APBaseViewController {

    //MARK: ------------- 全局属性
    
    let modiryRequest: APModifyRequest = APModifyRequest()

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
    
    //MARK: ------------- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改密码"
        view.backgroundColor = UIColor.white
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
   
    //MARK: ------------- 私有方法
    
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
            weakSelf?.modiryRequest.oldPassword = value
        }

        newPasswordCell.textBlock = { (key, value) in
            weakSelf?.modiryRequest.newPassword = value
        }

        repeatPasswordCell.textBlock = { (key, value) in
            weakSelf?.modiryRequest.repeatPassword = value
        }

        submitCell.buttonBlock = { (key, value) in
            let isEvaluate: Bool = (weakSelf?.evaluate())!
            if isEvaluate {
                weakSelf?.startModifyHttpRequest()
            }
        }
    }
    
    private func registerObserve() {
        
        weak var weakSelf = self
        self.kvoController.observe(self.modiryRequest,
                                   keyPaths: ["oldPassword",
                                              "newPassword",
                                              "repeatPassword"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let modiryModel = object as! APModifyRequest
            if  modiryModel.oldPassword.characters.count >= 6 &&
                modiryModel.newPassword.characters.count >= 6 &&
                modiryModel.repeatPassword.characters.count >= 6 {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func evaluate() -> Bool {

        if !modiryRequest.oldPassword.evaluate(regx: .password) {
            view.makeToast("旧密码输入错误")
            return false
        }
        if !modiryRequest.newPassword.evaluate(regx: .password) {
            view.makeToast("密码格式不正确")
            return false
        }
        if modiryRequest.newPassword != self.modiryRequest.repeatPassword{
            view.makeToast("再次输入密码不正确")
            return false
        }
        return true
    }
    
    private func startModifyHttpRequest() {
        weak var weakSelf = self
        modifySuccessShow {
            weakSelf?.navigationController?.popToRootViewController(animated: false)
            weakSelf?.ap_selectTabBar(atIndex: 2)
        }
    }


}
