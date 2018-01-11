//
//  APUnionThirdViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionOpenViewController: APUnionBaseViewController {
    
    //开通-获取验证码
    let registerMsgRequest = APRegisterMsgRequest()
    
    //开通
    var registQuickPayRequest: APRegistQuickPayRequest?

    var unionHttpTool: APUnionHttpTools?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registQuickPayRequest?.preSerial = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unionHttpTool?.ap_remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitCell.button.setTitle("确认开通", for: .normal)
        unionHttpTool = APUnionHttpTools(target: self,
                                         submitCell: submitCell,
                                         smsCodeCell: smsCodeCell)
        unionHttpTool?.ap_OpenDelegate = self
    }
    
    override func ap_httpSendSmsCode() {
        if registerMsgRequest.reserveMobileNo.count <= 0 {
            view.makeToast("请输入预留手机号")
            return
        }
        if registerMsgRequest.cardNo.count <= 0 {
            view.makeToast("请输入信用卡卡号")
            return
        }
        if !registerMsgRequest.reserveMobileNo.evaluate(regx: .mobile) {
            view.makeToast("预留手机号输入格式不正确")
            return
        }
        if !registerMsgRequest.cardNo.evaluate(regx: .bankCard) {
            view.makeToast("信用卡输入格式不正确")
            return
        }
        unionHttpTool?.ap_openSmsCodeHttp(request: registerMsgRequest)
    }
    
    override func ap_httpSubmit() {
        if registQuickPayRequest?.preSerial == "" {
            view.makeToast("请先获取验证码")
            return
        }
        unionHttpTool?.ap_openHttp(request: registQuickPayRequest!)
    }
    
    override func ap_initCreateSubviews() {
        super.ap_initCreateSubviews()
        
        view.addSubview(bankCardNoCell)
        view.addSubview(cvnNoCell)
        view.addSubview(validityDateCell)
        view.addSubview(phoneNoCell)
        view.addSubview(smsCodeCell)
        view.addSubview(agreedCell)
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
        
        agreedCell.snp.makeConstraints { (make) in
            make.top.equalTo(smsCodeCell.snp.bottom)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(toolBarView)
        }
        
        submitCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(agreedCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
    }
    
    override func ap_payEssentialTargetCallBacks() {
        super.ap_payEssentialTargetCallBacks()
        weak var weakSelf = self
        //获取用户输入的持卡人姓名
        realNameCell.textCell.textBlock = { (key, value) in
            weakSelf?.registerMsgRequest.realName = value
            weakSelf?.registQuickPayRequest?.realName = value
        }
        //获取用户输入的卡号
        bankCardNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.registerMsgRequest.cardNo = value
            weakSelf?.registQuickPayRequest?.cardNo = value
        }
        //获取用户输入的预留手机号
        phoneNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.registerMsgRequest.reserveMobileNo = value
            weakSelf?.registQuickPayRequest?.reserveMobileNo = value
        }
        //获取用户输入的方位标识
        cvnNoCell.textCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest?.cvn = value
        }
        //获取用户输入的有效期
        validityDateCell.textCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest?.expireDate = value
        }
        //获取用户输入的短信验证码
        smsCodeCell.smsCodeCell.textBlock = { (key, value) in
            weakSelf?.registQuickPayRequest?.smsCode = value
        }
        //是否阅读协议
        agreedCell.buttonBlock = { (key, value) in
            let button: UIButton = value as! UIButton
            weakSelf?.registQuickPayRequest?.isAgreed = button.isSelected
        }
        //点击阅读协议
        agreedCell.extButtonBlock = { (key, value) in
            let protocolVC = APBaseWebViewController()
            protocolVC.title = "银联快捷开通协议"
            protocolVC.urlService = APHttpService.unionPayAgreement
            weakSelf?.navigationController?.pushViewController(protocolVC, animated: true)
        }
    }
    
    override func ap_payEssentialRegisterObserve() {
        super.ap_payEssentialRegisterObserve()
        weak var weakSelf = self
        self.kvoController.observe(registQuickPayRequest,
                                   keyPaths: ["cardNo",
                                              "cvn",
                                              "expireDate",
                                              "reserveMobileNo",
                                              "smsCode",
                                              "isAgreed"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let quickPayModel = object as! APRegistQuickPayRequest
            if (quickPayModel.cardNo.count >= 12 &&
                quickPayModel.cvn.count >= 3 &&
                quickPayModel.expireDate.count >= 4 &&
                quickPayModel.reserveMobileNo.count >= 11 &&
                quickPayModel.smsCode.count >= 6 &&
                quickPayModel.isAgreed) {
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
}

extension APUnionOpenViewController: APUnionHttpOpenDelegate {
    
    func ap_unionHttpOpenSmsCodeSuccess(result: APRegisterMsgResponse) {
        registQuickPayRequest?.preSerial = result.preSerial
    }
    
    func ap_unionHttpOpenSuccess(result: APRegistQuickPayResponse) {
        APAlertManager.show(param: { (param) in
            param.apMessage = "开通成功"
            param.apConfirmTitle = "确定"
        }, confirm: { (action) in
            self.alertRegistSuccess()
        })
    }
}

extension APUnionOpenViewController {
    
    func alertRegistSuccess() {
        let model = APQuickPayRequest()
        model.realName = (registQuickPayRequest?.realName)!
        model.reserveMobileNo = (registQuickPayRequest?.reserveMobileNo)!
        model.cardNo = (registQuickPayRequest?.cardNo)!
        model.cvn = (registQuickPayRequest?.cvn)!
        model.integraFlag = (registQuickPayRequest?.integraFlag)!
        model.expireDate = (registQuickPayRequest?.expireDate)!
        NotificationCenter.default.post(Notification.init(name: TRAN_NOTIF_KEY,
                                                          object: model,
                                                          userInfo: nil))
        navigationController?.popViewController(animated: true)
    }
    
    public func setRegistQuickPayRequest(request: APRegistQuickPayRequest) {
        
        registQuickPayRequest = request
        
        registerMsgRequest.reserveMobileNo = request.reserveMobileNo
        registerMsgRequest.integraFlag = request.integraFlag
        registerMsgRequest.realName = request.realName
        registerMsgRequest.cardNo = request.cardNo
        
        registQuickPayRequest?.reserveMobileNo = request.reserveMobileNo
        registQuickPayRequest?.integraFlag = request.integraFlag
        registQuickPayRequest?.expireDate = request.expireDate
        registQuickPayRequest?.realName = request.realName
        registQuickPayRequest?.cardNo = request.cardNo
        registQuickPayRequest?.cvn = request.cvn
        
        validityDateCell.textCell.textField.text = request.expireDate
        phoneNoCell.textCell.textField.text = request.reserveMobileNo
        bankCardNoCell.textCell.textField.text = request.cardNo
        cvnNoCell.textCell.textField.text = request.cvn
    }
}
