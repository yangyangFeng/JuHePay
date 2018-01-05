//
//  APUnionFirstViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionFirstViewController: APUnionTranBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func ap_initCreateSubviews() {
        super.ap_initCreateSubviews()
        view.addSubview(bankCardNoCell)
        view.addSubview(cvnNoCell)
        view.addSubview(validityDateCell)
        view.addSubview(phoneNoCell)
        view.addSubview(smsCodeCell)
        view.addSubview(submitCell)
        bankCardNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(toolBarView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        cvnNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bankCardNoCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        validityDateCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cvnNoCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        phoneNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(validityDateCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        smsCodeCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneNoCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        submitCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(smsCodeCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
    }
    
    override func ap_payEssentialTargetCallBacks() {
        super.ap_payEssentialTargetCallBacks()
        weak var weakSelf = self
        //获取用户输入的卡号
        bankCardNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.transMsgRequest.cardNo = value
            weakSelf?.quickPayRequest.cardNo = value
        }
        //获取用户输入的方位标识
        cvnNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.quickPayRequest.cvn = value
        }
        //获取用户输入的有效期
        validityDateCell.textCell.textBlock = { (key, value) in
            weakSelf?.quickPayRequest.expireDate = value
        }
        //获取用户输入的预留手机号
        phoneNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.transMsgRequest.reserveMobileNo = value
            weakSelf?.quickPayRequest.reserveMobileNo = value
        }

        //获取用户输入的短信验证码
        smsCodeCell.smsCodeCell.textBlock = { (key, value) in
            weakSelf?.quickPayRequest.smsCode = value
        }
    }
    
    override func ap_payEssentialRegisterObserve() {
        super.ap_payEssentialRegisterObserve()
        weak var weakSelf = self
        let keyPaths = ["cvn", "expireDate", "cardNo", "reserveMobileNo", "smsCode"]
        self.kvoController.observe(quickPayRequest,
                                   keyPaths: keyPaths,
                                   options: [.new, .initial])
        { (observer, object, change) in
            let quickPayModel = object as! APQuickPayRequest
            if (quickPayModel.cardNo.characters.count >= 18 &&
                quickPayModel.cvn.characters.count >= 3 &&
                quickPayModel.expireDate.characters.count >= 4 &&
                quickPayModel.reserveMobileNo.characters.count >= 11 &&
                quickPayModel.smsCode.characters.count >= 6) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
}
