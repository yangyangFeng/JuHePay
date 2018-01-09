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
    
    var unionHttpTool: APUnionHttpTools?
    var unionTimeToos: APUnionTimeTools?
    
    
    override func goBackAction() {
        unionTimeToos?.ap_endTime()
        super.goBackAction()
    }

    deinit {
        print("APUnionTranBaseViewController------已释放")
        NotificationCenter.default.removeObserver(self, name: TRAN_NOTIF_KEY, object: nil)
        NotificationCenter.default.removeObserver(self, name: TRAN_CARD_NOTIF_KEY, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unionHttpTool?.ap_remove()
        unionTimeToos?.ap_endTime()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unionHttpTool = APUnionHttpTools(target: self,
                                         submitCell: submitCell,
                                         smsCodeCell: smsCodeCell)
        unionHttpTool?.ap_TranDelegate = self
        
        unionTimeToos = APUnionTimeTools(target: self)
        unionTimeToos?.ap_TimeDelegate = self
        
        transMsgRequest.realName = realName
        transMsgRequest.amount = totalAmount
        transMsgRequest.integraFlag = integraFlag
        
        quickPayRequest.realName = realName!
        quickPayRequest.amount = totalAmount!
        quickPayRequest.integraFlag = integraFlag!
        
        realNameCell.textCell.textField.text = realName
    }
    
    override func ap_httpSendSmsCode() {
        if transMsgRequest.reserveMobileNo.count <= 0 {
            view.makeToast("请输入预留手机号")
            return
        }
        if transMsgRequest.cardNo!.count <= 0 {
            view.makeToast("请输入信用卡卡号")
            return
        }
        if !transMsgRequest.reserveMobileNo.evaluate(regx: .mobile) {
            view.makeToast("预留手机号输入格式不正确")
            return
        }
        if !transMsgRequest.cardNo!.evaluate(regx: .bankCard) {
            view.makeToast("信用卡输入格式不正确")
            return
        }
        unionHttpTool?.ap_tranSmsCodeHttp(request: transMsgRequest)
    }
    
    override func ap_httpSubmit() {
        unionHttpTool?.ap_tranHttp(request: quickPayRequest)
    }
    
    override func ap_payEssentialRegisterObserve() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCardDetail(_:)), name: TRAN_CARD_NOTIF_KEY, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notificationQuickPayRequest(_:)), name: TRAN_NOTIF_KEY, object: nil)
    }
}

extension APUnionTranBaseViewController:
    APUnionHttpTranDelegate,
    APUnionTimeToolsDelegate {
    
    //MARK: --  APUnionHttpTranDelegate
    func ap_unionHttpTranSmsCodeSuccess(result: APTransMsgResponse) {
        quickPayRequest.preSerial = result.preSerial!
    }
    
    func ap_unionHttpTranSuccess(result: APQuickPayResponse) {
        //0失败、1处理中、2成功、3未开通
        if result.transStatus == "0" {
            gotoTranFaiure(result: result)
        }
        else if result.transStatus == "2" {
            gotoTranSuccess(result: result)
        }
        else if result.transStatus == "3" {
            pushOpenUnionPayVC(result: result)
        }
        else {
            submitCell.button.isEnabled = false
            unionTimeToos?.ap_startTime(orderNo: result.orderNo)
        }
    }
    
    //MARK: -- APUnionTimeToolsDelegate
    func ap_unionTimeToolsSuccess(quickPayResp: APQuickPayResponse) {
        submitCell.button.isEnabled = true
        if quickPayResp.transStatus == "0" {
            gotoTranFaiure(result: quickPayResp)
        }
        else if quickPayResp.transStatus == "2" {
            gotoTranSuccess(result: quickPayResp)
        }
    }
    
    func ap_unionTimeToolsFailure() {
        submitCell.button.isEnabled = true
        gotoTranDispose()
    }
}

extension APUnionTranBaseViewController {
    
    @objc func notificationCardDetail(_ notif: Notification) {
        
        toolBarView.selectCreditCardButton.isHidden = false
        let cardDetail = notif.object as! APQueryQuickPayCardDetail
        
        realNameCell.textCell.textField.text = cardDetail.realName!
        bankCardNoCell.textCell.textField.text = cardDetail.cardNo!
        
        quickPayRequest.cardNo = cardDetail.cardNo!
        quickPayRequest.realName = cardDetail.realName!
        
        transMsgRequest.cardNo = cardDetail.cardNo!
        transMsgRequest.realName = cardDetail.realName!
    }
    
    @objc func notificationQuickPayRequest(_ notif: Notification) {
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
            let unionOpenVC = APUnionOpenViewController()
            let quickPay = APRegistQuickPayRequest()
            quickPay.reserveMobileNo = self.quickPayRequest.reserveMobileNo
            quickPay.expireDate = self.quickPayRequest.expireDate
            quickPay.realName = self.quickPayRequest.realName
            quickPay.cardNo = self.quickPayRequest.cardNo
            quickPay.integraFlag = self.integraFlag
            quickPay.cvn = self.quickPayRequest.cvn
            unionOpenVC.totalAmount = self.totalAmount
            unionOpenVC.payPlaceTitle = self.payPlaceTitle
            unionOpenVC.integraFlag = self.integraFlag
            unionOpenVC.setRegistQuickPayRequest(request: quickPay)
            self.navigationController?.pushViewController(unionOpenVC, animated: true)
        })
    }
    
    func gotoTranSuccess(result: APQuickPayResponse) {
        
        let successVC = APCollectionSuccessViewController()
        successVC.resultDic = ["orderNo":result.orderNo,
                               "transDateTime":result.transTime,
                               "transAmount":result.transAmount,
                               "payServiceCode":payServiceCode]
        let navigation = APBaseNavigationViewController(rootViewController: successVC)
        self.present(navigation, animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        });
    }
    
    func gotoTranDispose() {
        let disposeVC = APCollectionDisposeViewController()
        let navigation = APBaseNavigationViewController(rootViewController: disposeVC)
        self.present(navigation, animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        });
    }
    
    func gotoTranFaiure(result: APQuickPayResponse) {
        let failureVC = APCollectionFailureViewController()
        failureVC.resultDic = ["respDesc":result.respMsg!]
        let navigation = APBaseNavigationViewController(rootViewController: failureVC)
        self.present(navigation, animated: true, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        });
    }
}
