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
    
    var forgetAccountCell: APForgetFirstStepAccountCell = APForgetFirstStepAccountCell()
    var forgetSmsCodeCell: APForgetFirstStepSmsCodeCell = APForgetFirstStepSmsCodeCell()
    var forgetSubmitCell: APForgetFirstStepSubmitCell = APForgetFirstStepSubmitCell()

    //MARK: ------------- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注意：私有方法调用顺序 (系统配置->创建子视图->子视图布局->监听子视图回调->注册通知)
        forgetFirstStepCreateSubViews()
        forgetFirstStepLayoutSubViews()
        forgetFirstStepTargetCallBacks()
        forgetFirstStepRegisterObserve()
    }
    
    //MARK: ------------- 私有方法
    
    private func forgetFirstStepCreateSubViews() {
        view.addSubview(forgetAccountCell)
        view.addSubview(forgetSmsCodeCell)
        view.addSubview(forgetSubmitCell)
    }
    
    private func forgetFirstStepLayoutSubViews() {
        forgetAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetSmsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetAccountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetSmsCodeCell.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
        
    }
    
    private func forgetFirstStepTargetCallBacks() {
        forgetAccountCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.mobile = value
        }
        
        forgetSmsCodeCell.textBlock = { (key, value) in
            APForgetViewController.forgetRequest.smsCode = value
        }
        
        forgetSubmitCell.buttonBlock = { (key, value) in
            let LastStepVC: APForgetViewController = APForgetLastStepViewController()
            self.navigationController?.pushViewController(LastStepVC, animated: true)
        }
    }
    
    private func forgetFirstStepRegisterObserve() {
        
    }
   

}








