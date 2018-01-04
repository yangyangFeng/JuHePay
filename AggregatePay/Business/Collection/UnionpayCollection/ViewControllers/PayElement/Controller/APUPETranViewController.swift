//
//  APUPETranViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUPETranViewController: APUPEBaseViewController {

    //交易-获取验证码
    let transMsgRequest = APTransMsgRequest()
    //交易-银联快捷
    let quickPayRequest = APQuickPayRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transMsgRequest.amount = totalAmount
        transMsgRequest.integraFlag = integraFlag
        
        quickPayRequest.amount = totalAmount!
        quickPayRequest.integraFlag = integraFlag!
    }
    
    override func ap_httpSendSmsCode() {
        view.AP_loadingBegin()
        waitSendSmsCode()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.transMsg,
                          params: transMsgRequest,
                          aClass: APTransMsgResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
                            self.startSendSmsCode()
                            self.disposeTranMsg(response: baseResp)
        }, failure: {(baseError) in
            self.endSendSmsCode()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    override func ap_httpSubmit() {
        view.AP_loadingBegin()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.quickPay,
                          params: quickPayRequest,
                          aClass: APQuickPayResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
                            self.disposeQuickPay(response: baseResp)
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    override func ap_payEssentialTargetCallBacks() {
        
        super.ap_payEssentialTargetCallBacks()
        
        weak var weakSelf = self
        //获取用户输入的持卡人姓名
        realNameCell.textCell.textBlock = { (key, value) in
            weakSelf?.transMsgRequest.realName = value
            weakSelf?.quickPayRequest.realName = value
        }
        //获取用户输入的卡号
        bankCardNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.transMsgRequest.cardNo = value
            weakSelf?.quickPayRequest.cardNo = value
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
        weak var weakSelf = self
        self.kvoController.observe(quickPayRequest,
                                   keyPaths: ["realName",
                                              "cardNo",
                                              "reserveMobileNo",
                                              "smsCode"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let quickPayModel = object as! APQuickPayRequest
            if (quickPayModel.reserveMobileNo.characters.count >= 11 &&
                quickPayModel.realName.characters.count >= 1 &&
                quickPayModel.cardNo.characters.count >= 18 &&
                quickPayModel.smsCode.characters.count >= 4) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
}

extension APUPETranViewController {
    
    func disposeTranMsg(response: APBaseResponse) {
        let transMsg = response as! APTransMsgResponse
        quickPayRequest.preSerial = transMsg.preSerial!
    }
    
    func disposeQuickPay(response: APBaseResponse) {
        
        APAlertManager.show(param: { (param) in
            param.apMessage = "开通"
            param.apConfirmTitle = "去开通"
        }, confirm: { (action) in
            let upeRegisVC = APUPERegisViewController()
            self.navigationController?.pushViewController(upeRegisVC, animated: true)
        })
    }
    
}






















