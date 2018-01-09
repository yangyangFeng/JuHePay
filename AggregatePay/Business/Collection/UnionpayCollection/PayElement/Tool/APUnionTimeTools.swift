//
//  APUnionTimeTools.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/5.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APUnionTimeTools: NSObject {
    
    public weak var ap_TimeDelegate: APUnionTimeToolsDelegate?
    var unionHttpTool: APUnionHttpTools?
    
    let request = APQueryQuickPayResultRequest()
    var countDownTimer: Timer?
    var isCancelRequest: Bool = false
    var remainingSeconds: Int = 0 {
        willSet {
            if newValue <= 0 {
                endTime()
                ap_TimeDelegate?.ap_unionTimeToolsFailure()
            }
        }
    }

    init(target: UIViewController) {
        super.init()
        unionHttpTool = APUnionHttpTools(target: target)
        unionHttpTool?.ap_ResultDelegate = self
    }
    
    public func ap_startTime(orderNo: String) {
        request.orderNo = orderNo
        countDownTimer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(updateTime(_:)),
                                              userInfo: nil,
                                              repeats: true)
        RunLoop.main.add(countDownTimer!, forMode:RunLoopMode.commonModes)
        isCancelRequest = false
        remainingSeconds = 30
        unionHttpTool?.loadBegan()
        startHttp()
    }
    
    public func ap_endTime() {
        endTime()
    }
    
    private func startHttp() {
        if !self.isCancelRequest {
            self.perform(#selector(self.sendHttp), with: nil, afterDelay: 3)
        }
    }
    
    private func endTime() {
        unionHttpTool?.loadEnd()
        isCancelRequest = true
        countDownTimer?.invalidate()
        countDownTimer = nil
    }
    
    @objc func sendHttp() {
        unionHttpTool?.ap_resultHttp(request: request)
    }
    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
}

extension APUnionTimeTools:
    APUnionHttpResultDelegate{
    
    func ap_unionHttpTranResultSuccess(result: APQueryQuickPayResultResponse) {
        if result.transStatus == "2" ||
            result.transStatus == "0" {
            endTime()
            let quickPay = APQuickPayResponse()
            quickPay.orderNo = result.orderNo
            quickPay.merchantName = result.merchantName
            quickPay.merchantNo = result.merchantNo
            quickPay.transAmount = result.transAmount
            quickPay.transTime = result.transTime
            quickPay.transStatus = result.transStatus
            self.ap_TimeDelegate?.ap_unionTimeToolsSuccess(quickPayResp: quickPay)
            
        }
        else {
            startHttp()
        }
    }
    
    func ap_unionHttpTranResultFailure() {
        startHttp()
    }
}

protocol APUnionTimeToolsDelegate: NSObjectProtocol {
    func ap_unionTimeToolsSuccess(quickPayResp: APQuickPayResponse);
    func ap_unionTimeToolsFailure()
}

















