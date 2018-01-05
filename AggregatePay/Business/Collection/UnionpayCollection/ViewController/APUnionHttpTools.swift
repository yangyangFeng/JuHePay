//
//  APUnionHttpTools.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

//MARK: ----- APUnionHttpTools

class APUnionHttpTools: NSObject {
    
    private var m_SmsCodeCell: APPayElementSmsCodeCell?
    private var m_SubmitCell: APSubmitFormsCell?
    private var m_Target: UIViewController?
    
    public var ap_TranDelegate: APUnionHttpTranDelegate?
    public var ap_OpenDelegate: APUnionHttpOpenDelegate?
    
    init(target: UIViewController,
         submitCell: APSubmitFormsCell,
         smsCodeCell: APPayElementSmsCodeCell) {
        m_SmsCodeCell = smsCodeCell
        m_SubmitCell = submitCell
        m_Target = target
    }
}

//MARK: ----- APUnionHttpTools -- Extension(交易)
extension APUnionHttpTools {
    
    //MARK:---Pubilc
    public func ap_tranSmsCodeHttp(request: APTransMsgRequest) {
        let transMsg = request.copy() as! APTransMsgRequest
        transMsg.amount = String(format: "%.f", (Double(transMsg.amount!)! * 100))
        loadBegan()
        waitSendSmsCode()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.transMsg,
                          params: transMsg,
                          aClass: APTransMsgResponse.self,
                          success: { (baseResp) in
                            self.loadEnd()
                            self.startSendSmsCode()
                            self.makeToast(msg: baseResp.respMsg!)
                            self.m_disposeTranSmsCodeReslut(response: baseResp)
        }, failure: {(baseError) in
            self.loadEnd()
            self.endSendSmsCode()
            self.makeToast(msg: baseError.message!)
        })
    }
    
    public func ap_tranHttp(request: APQuickPayRequest) {
        let quickPay = request.copy() as! APQuickPayRequest
        quickPay.amount = String(format: "%.f", (Double(quickPay.amount)! * 100))
        loadBegan()
        loadSubmitBegan()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.quickPay,
                          params: quickPay,
                          aClass: APQuickPayResponse.self,
                          success: { (baseResp) in
                            self.loadEnd()
                            self.loadSubmitEnd()
                            self.m_disposeTranReslut(response: baseResp)
        }, failure: {(baseError) in
            self.loadEnd()
            self.loadSubmitEnd()
            self.makeToast(msg: baseError.message!)
        })
    }
    
    //MARK:---Private
    private func m_disposeTranSmsCodeReslut(response: APBaseResponse) {
        let result = response as! APTransMsgResponse
        ap_TranDelegate?.ap_unionHttpTranSmsCodeSuccess(result: result)
    }
    
    private func m_disposeTranReslut(response: APBaseResponse) {
        let result = response as! APQuickPayResponse
        ap_TranDelegate?.ap_unionHttpTranSuccess(result: result)
    }
}

//MARK: ----- APUnionHttpTools -- Extension(开通)
extension APUnionHttpTools {
    
    //MARK:---Pubilc
    
    public func ap_openSmsCodeHttp(request: APRegisterMsgRequest) {
        loadBegan()
        waitSendSmsCode()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.registerMsg,
                          params: request,
                          aClass: APRegisterMsgResponse.self,
                          success: { (baseResp) in
                            self.loadEnd()
                            self.startSendSmsCode()
                            self.makeToast(msg: baseResp.respMsg!)
                            self.m_disposeOpenSmsCodeReslut(response: baseResp)
        }, failure: {(baseError) in
            self.loadEnd()
            self.endSendSmsCode()
            self.makeToast(msg: baseError.message!)
        })
    }
    
    public func ap_openHttp(request: APRegistQuickPayRequest) {
        loadBegan()
        loadSubmitBegan()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.registQuickPay,
                          params: request,
                          aClass: APRegistQuickPayResponse.self,
                          success: { (baseResp) in
                            self.loadEnd()
                            self.loadSubmitEnd()
                            self.m_disposeOpenReslut(response: baseResp)
        }, failure: {(baseError) in
            self.loadEnd()
            self.loadSubmitEnd()
            self.makeToast(msg: baseError.message!)
        })
    }

    //MARK:---Private
    private func m_disposeOpenSmsCodeReslut(response: APBaseResponse) {
        let result = response as! APRegisterMsgResponse
        ap_OpenDelegate?.ap_unionHttpOpenSmsCodeSuccess(result: result)
    }
    
    private func m_disposeOpenReslut(response: APBaseResponse) {
        let result = response as! APRegistQuickPayResponse
        ap_OpenDelegate?.ap_unionHttpOpenSuccess(result: result)
    }
}

//MARK: ----- APUnionHttpTools -- Extension(私有方法)

extension APUnionHttpTools {
    
    func makeToast(msg: String) {
        m_Target?.view.makeToast(msg)
    }
    
    func loadBegan() {
        m_Target?.view.AP_loadingBegin()
    }
    
    func loadEnd() {
        m_Target?.view.AP_loadingEnd()
    }
    
    func loadSubmitBegan() {
        m_SubmitCell?.loading(isLoading: true, isComplete: nil)
    }
    
    func loadSubmitEnd() {
        m_SubmitCell?.loading(isLoading: false, isComplete: nil)
    }
    
    func waitSendSmsCode() {
        m_SmsCodeCell?.smsCodeCell.sendSmsCodeButton.countingStatus = .wait
    }
    
    func startSendSmsCode() {
        m_SmsCodeCell?.smsCodeCell.sendSmsCodeButton.countingStatus = .start
    }
    
    func endSendSmsCode() {
        m_SmsCodeCell?.smsCodeCell.sendSmsCodeButton.countingStatus = .end
    }
}

//MARK: ----- APUnionHttpTools -- Extension(代理)

protocol APUnionHttpDelegate: NSObjectProtocol {
    
}

protocol APUnionHttpTranDelegate: APUnionHttpDelegate {
    func ap_unionHttpTranSmsCodeSuccess(result: APTransMsgResponse)
    func ap_unionHttpTranSuccess(result: APQuickPayResponse)
}

protocol APUnionHttpOpenDelegate: APUnionHttpDelegate {
    
    func ap_unionHttpOpenSmsCodeSuccess(result: APRegisterMsgResponse)
    func ap_unionHttpOpenSuccess(result: APRegistQuickPayResponse)
    
}








