//
//  APUnionTranBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionTranBaseViewController: APUnionBaseViewController {

    //交易-获取验证码
    let transMsgRequest = APTransMsgRequest()
    
    //交易-银联快捷
    let quickPayRequest = APQuickPayRequest()
    
    //网络工具
    lazy var unionHttpTool: APUnionHttpTools = {
        let tool = APUnionHttpTools(target: self, submitCell: submitCell, smsCodeCell: smsCodeCell)
        tool.ap_TranDelegate = self
        return tool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quickPayRequest.preSerial = "P10011637658"
        transMsgRequest.realName = realName
        transMsgRequest.amount = totalAmount
        transMsgRequest.integraFlag = integraFlag
        
        quickPayRequest.realName = realName!
        quickPayRequest.amount = totalAmount!
        quickPayRequest.integraFlag = integraFlag!
        
        realNameCell.textCell.textField.text = realName
    }
    
    override func ap_httpSendSmsCode() {
        unionHttpTool.ap_tranSmsCodeHttp(request: transMsgRequest)
    }
    
    override func ap_httpSubmit() {
        unionHttpTool.ap_tranHttp(request: quickPayRequest)
    }
    
    override func ap_payEssentialRegisterObserve() {
        NotificationCenter.default.addObserver(self, selector: #selector(notification(_:)), name: TRAN_NOTIF_KEY, object: nil)
    }
}

extension APUnionTranBaseViewController: APUnionHttpTranDelegate {
    
    func ap_unionHttpTranSmsCodeSuccess(result: APTransMsgResponse) {
        quickPayRequest.preSerial = result.preSerial!
    }
    
    func ap_unionHttpTranSuccess(result: APQuickPayResponse) {
        if result.transStatus == "0" {
            gotoTranFaiure(result: result)
        }
        else if result.transStatus == "1" {
            
        }
        else if result.transStatus == "2" {
            gotoTranSuccess(result: result)
        }
        else if result.transStatus == "3" {
            pushOpenUnionPayVC(result: result)
        }
        else {
            pushOpenUnionPayVC(result: result)
        }
        
    }
}

extension APUnionTranBaseViewController {
    
    @objc func notification(_ notif: Notification) {
        toolBarView.selectCreditCardButton.isHidden = false
        let quickPay = notif.object as! APQuickPayRequest
        quickPayRequest.cvn = quickPay.cvn
        quickPayRequest.cardNo = quickPay.cardNo
        quickPayRequest.amount = quickPay.amount
        quickPayRequest.realName = quickPay.realName
        quickPayRequest.integraFlag = quickPay.integraFlag
        quickPayRequest.reserveMobileNo = quickPay.reserveMobileNo
        quickPayRequest.expireDate = quickPay.expireDate
        
        transMsgRequest.cardNo = quickPay.cardNo
        transMsgRequest.amount = quickPay.amount
        transMsgRequest.realName = quickPay.realName
        transMsgRequest.integraFlag = quickPay.integraFlag
        transMsgRequest.reserveMobileNo = quickPay.reserveMobileNo
        
        cvnNoCell.textCell.textField.text = quickPay.cvn
        bankCardNoCell.textCell.textField.text = quickPay.cardNo
        phoneNoCell.textCell.textField.text = quickPay.reserveMobileNo
        validityDateCell.textCell.textField.text = quickPay.expireDate
    }
    
    func pushOpenUnionPayVC(result: APQuickPayResponse) {
        APAlertManager.show(param: { (param) in
            param.apMessage = "该银行卡未开通银联快捷支付，请重新获取验证码进行开通。"
            param.apConfirmTitle = "确定"
        }, confirm: { (action) in
            let quickPay = APRegistQuickPayRequest()
            quickPay.reserveMobileNo = self.quickPayRequest.reserveMobileNo
            quickPay.expireDate = self.quickPayRequest.expireDate
            quickPay.realName = self.quickPayRequest.realName
            quickPay.cardNo = self.quickPayRequest.cardNo
            quickPay.cvn = self.quickPayRequest.cvn
            
            let unionOpenVC = APUnionOpenViewController()
            unionOpenVC.totalAmount = self.totalAmount
            unionOpenVC.payPlaceTitle = self.payPlaceTitle
            unionOpenVC.integraFlag = self.integraFlag
            unionOpenVC.setRegistQuickPayRequest(request: quickPay)
            self.navigationController?.pushViewController(unionOpenVC, animated: true)
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
        navigationController?.popToRootViewController(animated: true)
        
        let lastVC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        let homeVC = lastVC.selectedViewController
        homeVC?.present(navigation, animated: true, completion: nil);
    }
    
    func gotoTranDispose(result: APQuickPayResponse) {
        self.navigationController?.popToRootViewController(animated: true)
        let disposeVC = APCollectionDisposeViewController()
        let navigation = APBaseNavigationViewController(rootViewController: disposeVC)
        
        let lastVC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        let homeVC = lastVC.selectedViewController
        homeVC?.present(navigation, animated: true, completion: nil);
    }
    
    func gotoTranFaiure(result: APQuickPayResponse) {
        self.navigationController?.popToRootViewController(animated: true)
        let failureVC = APCollectionFailureViewController()
        failureVC.resultDic = ["respDesc":result.respMsg!]
        let navigation = APBaseNavigationViewController(rootViewController: failureVC)
        
        let lastVC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        let homeVC = lastVC.selectedViewController
        homeVC?.present(navigation, animated: true, completion: nil);
    }
}
