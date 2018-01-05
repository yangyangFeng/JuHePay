//
//  APPayEssentialViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 银联快捷支付要素 (开通)
 */
class APUPERegisViewController: APUPEBaseViewController {
    
    //开通-获取验证码
    let registerMsgRequest = APRegisterMsgRequest()
    
    //开通
    let registQuickPayRequest = APRegistQuickPayRequest()
    
//    var realName: String = "" {
//        willSet {
//            realNameCell.textCell.textField.text = newValue
//            registerMsgRequest.realName = newValue
//            registQuickPayRequest.realName = newValue
//        }
//    }
    var cardNo: String = "" {
        willSet {
            bankCardNoCell.textCell.textField.text = newValue
            registerMsgRequest.cardNo = newValue
            registQuickPayRequest.cardNo = newValue
        }
    }
    var reserveMobileNo: String = ""{
        willSet {
            phoneNoCell.textCell.textField.text = newValue
            registerMsgRequest.reserveMobileNo = newValue
            registQuickPayRequest.reserveMobileNo = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        realNameCell.textCell.textField.isUserInteractionEnabled = false
        registerMsgRequest.integraFlag = integraFlag
        registQuickPayRequest.integraFlag = integraFlag!
    }
    
    override func ap_httpSendSmsCode() {
        
        view.AP_loadingBegin()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.registerMsg,
                          params: registerMsgRequest,
                          aClass: APRegisterMsgResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
        })
    }
    
    override func ap_httpSubmit() {
        let model = APQuickCardInfoModel()
        model.realName = registQuickPayRequest.realName
        model.reserveMobileNo = registQuickPayRequest.reserveMobileNo
        model.cardNo = registQuickPayRequest.cardNo
        model.cvn = registQuickPayRequest.cvn
        model.integraFlag = registQuickPayRequest.integraFlag
        model.expireDate = registQuickPayRequest.expireDate
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: TRAN_NOTIFICATION_KEY), object: model, userInfo: nil))
        navigationController?.popViewController(animated: true)
        return
            
        view.AP_loadingBegin()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.registQuickPay,
                          params: registQuickPayRequest,
                          aClass: APRegistQuickPayResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
        })
        
    }
    
    override func ap_payEssentialTargetCallBacks() {
        super.ap_payEssentialTargetCallBacks()
        weak var weakSelf = self
        //获取用户输入的持卡人姓名
        realNameCell.textCell.textBlock = { (key, value) in
            weakSelf?.registerMsgRequest.realName = value
            weakSelf?.registQuickPayRequest.realName = value
        }
        //获取用户输入的卡号
        bankCardNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.registerMsgRequest.cardNo = value
            weakSelf?.registQuickPayRequest.cardNo = value
        }
        //获取用户输入的预留手机号
        phoneNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.registerMsgRequest.reserveMobileNo = value
            weakSelf?.registQuickPayRequest.reserveMobileNo = value
        }
        //获取用户输入的方位标识
        cvnNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest.cvn = value
        }
        //获取用户输入的有效期
        validityDateCell.textCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest.expireDate = value
        }
        //获取用户输入的短信验证码
        smsCodeCell.smsCodeCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest.smsCode = value
        }
    }
    
    override func ap_payEssentialRegisterObserve() {
        weak var weakSelf = self
        self.kvoController.observe(registQuickPayRequest,
                                   keyPaths: ["cvn",
                                              "expireDate",
                                              "cardNo",
                                              "reserveMobileNo",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let quickPayModel = object as! APRegistQuickPayRequest
            if (quickPayModel.reserveMobileNo.characters.count >= 11 &&
                quickPayModel.cvn.characters.count >= 3 &&
                quickPayModel.expireDate.characters.count >= 4 &&
                quickPayModel.cardNo.characters.count >= 18 &&
                quickPayModel.smsCode.characters.count >= 6) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
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
    
}



