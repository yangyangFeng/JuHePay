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
    
    var forgetFirstStepAccountCell: APForgetFirstStepAccountCell = APForgetFirstStepAccountCell()
    var forgetFirstStepSmsCodeCell: APForgetFirstStepSmsCodeCell = APForgetFirstStepSmsCodeCell()
    var forgetFirstStepSubmitCell: APForgetFirstStepSubmitCell = APForgetFirstStepSubmitCell()

    //MARK: ------------- 生命周期
    
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
        forgetFirstStepAccountCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.mobile = value
        }
        
        forgetFirstStepSmsCodeCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.smsCode = value
        }
        
        forgetFirstStepSubmitCell.buttonBlock = { (key, value) in
            let LastStepVC: APForgetViewController = APForgetLastStepViewController()
            self.navigationController?.pushViewController(LastStepVC, animated: true)
        }
    }
    
    private func forgetFirstStepRegisterObserve() {
        self.kvoController.observe(APForgetViewController.forgetRequest,
                                   keyPaths: ["mobile",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let forgetModel = object as! APForgetRequest
            if  forgetModel.mobile.characters.count >= 11 &&
                forgetModel.smsCode.characters.count >= 4 {
                self.forgetFirstStepSubmitCell.isEnabled = true
            }
            else {
                self.forgetFirstStepSubmitCell.isEnabled = false
            }
        }
    }
   

}








