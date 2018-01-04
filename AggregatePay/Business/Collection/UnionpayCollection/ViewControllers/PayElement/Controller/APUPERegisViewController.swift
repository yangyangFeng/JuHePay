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
    
    var realName: String = "" {
        willSet {
            realNameCell.textCell.textField.text = newValue
        }
    }
    var cardNo: String = "" {
        willSet {
            bankCardNoCell.textCell.textField.text = newValue
        }
    }
    var reserveMobileNo: String = ""{
        willSet {
            phoneNoCell.textCell.textField.text = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func ap_httpSendSmsCode() {
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.registerMsg,
                          params: registerMsgRequest,
                          aClass: APRegisterMsgResponse.self,
                          success: { (baseResp) in
            
        }, failure: {(baseError) in
            
        })
    }
    
    override func ap_httpSubmit() {
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.registQuickPay,
                          params: registQuickPayRequest,
                          aClass: APRegistQuickPayResponse.self,
                          success: { (baseResp) in
            
        }, failure: {(baseError) in
            
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
        //获取用户输入的短信验证码
        smsCodeCell.smsCodeCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest.smsCode = value
        }
    }
    
    override func ap_payEssentialRegisterObserve() {
        
    }
    
}



