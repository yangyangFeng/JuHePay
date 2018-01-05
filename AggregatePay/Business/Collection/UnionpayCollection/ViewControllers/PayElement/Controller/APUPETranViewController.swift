//
//  APUPETranViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUPETranViewController: APUPEBaseViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: TRAN_NOTIFICATION_KEY), object: nil)
    }
 
    //交易-获取验证码
    let transMsgRequest = APTransMsgRequest()
    
    //交易-银联快捷
    let quickPayRequest = APQuickPayRequest()
    
    var isOpenQuick = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transMsgRequest.amount = totalAmount
        transMsgRequest.integraFlag = integraFlag
        
        quickPayRequest.amount = totalAmount!
        quickPayRequest.integraFlag = integraFlag!
        quickPayRequest.preSerial = "12323123"
    }
    
    override func ap_httpSendSmsCode() {
        
        let tempTransMsgRequest = transMsgRequest.copy() as! APTransMsgRequest
        let amountNum = Double(transMsgRequest.amount!)! * 100
        tempTransMsgRequest.amount = String(format: "%.f", amountNum)
        view.AP_loadingBegin()
        waitSendSmsCode()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.transMsg,
                          params: tempTransMsgRequest,
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
        let tempQuickPayRequest = quickPayRequest.copy() as! APQuickPayRequest
        let amountNum = Double(quickPayRequest.amount)! * 100
        tempQuickPayRequest.amount = String(format: "%.f", amountNum)
        view.AP_loadingBegin()
        submitCell.loading(isLoading: true, isComplete: nil)
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.quickPay,
                          params: tempQuickPayRequest,
                          aClass: APQuickPayResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
                            self.submitCell.loading(isLoading: false, isComplete: {
                                self.disposeQuickPay(response: baseResp)
                            })
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
            self.submitCell.loading(isLoading: false, isComplete: nil)
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
                quickPayModel.smsCode.characters.count >= 6) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(notification(_:)), name: NSNotification.Name(rawValue: TRAN_NOTIFICATION_KEY), object: nil)
    }
    
    override func ap_initCreateSubviews() {
        super.ap_initCreateSubviews()
        
        view.addSubview(realNameCell)
        view.addSubview(bankCardNoCell)
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
        
        phoneNoCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(bankCardNoCell.snp.bottom)
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

extension APUPETranViewController {
    
    @objc func notification(_ notif: Notification) {
        let quickCardInfoModel = notif.object as! APQuickCardInfoModel
        setQuickCardInfoModel(quickCardInfoModel: quickCardInfoModel)
    }
    
    func disposeTranMsg(response: APBaseResponse) {
        let transMsg = response as! APTransMsgResponse
        quickPayRequest.preSerial = transMsg.preSerial!
    }
    
    func disposeQuickPay(response: APBaseResponse) {
        let quickPay = response as! APQuickPayResponse
        if  quickPay.transStatus != "0" {
            gotoRegisterQuickCard()
        }
        else {
            gotoTranSuccess(result: quickPay)
        }
    }
    
    func gotoRegisterQuickCard() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "该银行卡未开通银联快捷支付，请重新获取验证码进行开通。"
            param.apConfirmTitle = "确定"
        }, confirm: { (action) in
            let upeRegisVC = APUPERegisViewController()
            upeRegisVC.realName = self.quickPayRequest.realName
            upeRegisVC.reserveMobileNo = self.quickPayRequest.reserveMobileNo
            upeRegisVC.cardNo = self.quickPayRequest.cardNo
            upeRegisVC.totalAmount = self.totalAmount
            upeRegisVC.payPlaceTitle = self.payPlaceTitle
            upeRegisVC.integraFlag = self.integraFlag
            self.navigationController?.pushViewController(upeRegisVC, animated: true)
        })
    }
    
    func gotoTranSuccess(result: APQuickPayResponse) {
        self.navigationController?.popToRootViewController(animated: true)
        let successVC = APCollectionSuccessViewController()
        successVC.resultDic = ["orderNo":result.innerOrderNo!,
                               "transDateTime":result.transTime!,
                               "transAmount":result.transAmount!,
                               "payServiceCode":"UnioppayQuick"]
        let navigation = APBaseNavigationViewController(rootViewController: successVC)
        let lastVC = APPDElEGATE.window?.rootViewController?.childViewControllers.last
        lastVC?.present(navigation, animated: true, completion: nil);
    }
    
    func gotoTranFaiure(result: APQuickPayResponse) {
        self.navigationController?.popToRootViewController(animated: true)
        let failureVC = APCollectionFailureViewController()
        failureVC.resultDic = ["respDesc":result.respMsg!]
        let navigation = APBaseNavigationViewController(rootViewController: failureVC)
        let lastVC = APPDElEGATE.window?.rootViewController?.childViewControllers.last
        lastVC?.present(navigation, animated: true, completion: nil);
    }
    
    func setQuickCardInfoModel(quickCardInfoModel :APQuickCardInfoModel) {
        
        isOpenQuick = true
        realNameCell.textCell.textField.isUserInteractionEnabled = false
        toolBarView.selectCreditCardButton.isHidden = false
        
        realNameCell.textCell.textField.text = quickCardInfoModel.realName
        bankCardNoCell.textCell.textField.text = quickCardInfoModel.cardNo
        phoneNoCell.textCell.textField.text = quickCardInfoModel.reserveMobileNo
        cvnNoCell.textCell.textField.text = quickCardInfoModel.cvn
        validityDateCell.textCell.textField.text = quickCardInfoModel.expireDate
        smsCodeCell.smsCodeCell.textField.text = ""
        
        transMsgRequest.cardNo = quickCardInfoModel.cardNo
        transMsgRequest.realName = quickCardInfoModel.realName
        transMsgRequest.reserveMobileNo = quickCardInfoModel.reserveMobileNo
        transMsgRequest.integraFlag = quickCardInfoModel.integraFlag
        
        quickPayRequest.cardNo = quickCardInfoModel.cardNo
        quickPayRequest.realName = quickCardInfoModel.realName
        quickPayRequest.reserveMobileNo = quickCardInfoModel.reserveMobileNo
        quickPayRequest.integraFlag = quickCardInfoModel.integraFlag!
        
        quickPayRequest.smsCode = ""
        quickPayRequest.preSerial = ""
    }
}























