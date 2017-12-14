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
    
    let forgetLastPasswordCell: APForgetLastStepPasswordCell = APForgetLastStepPasswordCell()
    let forgetLastSubmitCell: APForgetLastSubmitCell = APForgetLastSubmitCell()
    
    //MARK: ------------- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注意：私有方法调用顺序 (系统配置->创建子视图->子视图布局->监听子视图回调->注册通知)
        forgetLastStepCreateSubViews()
        forgetLastStepLayoutSubViews()
        forgetLastStepTargetCallBacks()
        forgetLastStepRegisterObserve()
    }
    
    //MARK: ------------- 私有方法
    
    private func forgetLastStepCreateSubViews() {
        view.addSubview(forgetLastPasswordCell)
        view.addSubview(forgetLastSubmitCell)
    }
    
    private func forgetLastStepLayoutSubViews() {
        forgetLastPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetLastSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetLastPasswordCell.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
    }
    
    private func forgetLastStepTargetCallBacks() {
        forgetLastPasswordCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.password = value
        }
        
        forgetLastSubmitCell.buttonBlock = { (key, value) in
            
        }
    }
    
    private func forgetLastStepRegisterObserve() {
        
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
                self.forgetLastSubmitCell.isEnabled = true
            }
            else {
                self.forgetLastSubmitCell.isEnabled = false
            }
        }
    }

}







