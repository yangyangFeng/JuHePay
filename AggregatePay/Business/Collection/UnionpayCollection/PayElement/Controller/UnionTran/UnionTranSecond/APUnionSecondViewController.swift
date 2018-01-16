//
//  APUnionSecondViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionSecondViewController: APUnionTranBaseViewController {
    
    func setQuickPayCardDetail(cardDetail: APQueryQuickPayCardDetail) {
        
        transMsgRequest.realName = cardDetail.realName
        transMsgRequest.cardNo = cardDetail.cardNo
        
        quickPayRequest.realName = cardDetail.realName!
        quickPayRequest.cardNo = cardDetail.cardNo!
        
        realNameCell.textCell.textField.text = cardDetail.realName
        bankCardNoCell.textCell.textField.text = cardDetail.cardNo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toolBarView.selectCreditCardButton.isHidden = false
        bankCardNoCell.textCell.textField.rightViewMode = .always
        
    }
    
    override func ap_initCreateSubviews() {
        super.ap_initCreateSubviews()
        
        view.addSubview(realNameCell)
        view.addSubview(bankCardNoCell)
        view.addSubview(validityDateCell)
        view.addSubview(phoneNoCell)
        view.addSubview(smsCodeCell)
        view.addSubview(submitCell)
        
        realNameCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(toolBarView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        bankCardNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(realNameCell.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(toolBarView)
        }
        
        validityDateCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bankCardNoCell.snp.bottom)
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
        
        bankCardNoCell.payEssentialRightViewBlock = { param in
            weakSelf?.transMsgRequest.cardNo = ""
            weakSelf?.quickPayRequest.cardNo = ""
        }
        
        //获取用户输入的预留手机号
        phoneNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.transMsgRequest.reserveMobileNo = value
            weakSelf?.quickPayRequest.reserveMobileNo = value
        }
        //获取用户输入的有效期
        validityDateCell.textCell.textBlock = { (key, value) in
            weakSelf?.quickPayRequest.expireDate = value
        }
        //获取用户输入的短信验证码
        smsCodeCell.smsCodeCell.textBlock = { (key, value) in
            weakSelf?.quickPayRequest.smsCode = value
        }
    }
    
    override func ap_payEssentialRegisterObserve() {
        super.ap_payEssentialRegisterObserve()
        weak var weakSelf = self
        self.kvoController.observe(quickPayRequest,
                                   keyPaths: ["cardNo",
                                              "reserveMobileNo",
                                              "expireDate",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let quickPayModel = object as! APQuickPayRequest
            if (quickPayModel.cardNo.count >= 12 &&
                quickPayModel.reserveMobileNo.count >= 11 &&
                quickPayModel.expireDate.count >= 4 &&
                quickPayModel.smsCode.count >= 6) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
}

