//
//  APCollectionDisposeViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionDisposeViewController: APCollectionResultViewController {
    var innerOrderNo: String?
    let datas = ["请稍后再“账单”中查询结果"]
    var isCancelRequest: Bool = false
    var countDownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            if newValue <= 0 {
                print("倒计时结束")
                endTime()
                ap_dismiss()
            }
        }
    }
    
    //网络工具
    lazy var unionHttpTool: APUnionHttpTools = {
        let tool = APUnionHttpTools(target: self)
        tool.ap_ResultDelegate = self
        return tool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImageView.theme_image = ["collection_failure_icon"]
        headerTitleLabel.text = "未查询到交易结果"
        tableView.register(APCollectionDisposeCell.self, forCellReuseIdentifier: "APCollectionDisposeCell")
        isCancelRequest = false
        httpResult()
        startTime()
    }
    
    override func ap_dismiss() {
        isCancelRequest = true
        super.ap_dismiss()
    }

    override func numberRow(tableView: UITableView) -> Int {
        return datas.count
    }

    override func ap_tableView(tableView: UITableView,
                               indexPath: IndexPath) -> UITableViewCell {
        let cell = APCollectionDisposeCell.cellWithTableView(tableView) as! APCollectionDisposeCell
        cell.titleLabel.text = datas[indexPath.row]
        return cell
    }
    
    func httpResult() {
        if !self.isCancelRequest {
            self.perform(#selector(self.startHttp),
                         with: nil,
                         afterDelay: 3)
        }
    }
}

extension APCollectionDisposeViewController {

    @objc func startHttp() {
            let request = APQueryQuickPayResultRequest()
            request.orderNo = innerOrderNo!
            unionHttpTool.ap_resultHttp(request: request)
    }
    
    func startTime() {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1,
                                              target: self,
                                              selector: #selector(updateTime(_:)),
                                              userInfo: nil,
                                              repeats: true)
        RunLoop.main.add(countDownTimer!, forMode:RunLoopMode.commonModes)
        remainingSeconds = 30
    }
    
    func endTime() {
        isCancelRequest = true
        countDownTimer?.invalidate()
        countDownTimer = nil
    }
    
    @objc func updateTime(_ timer: Timer) {
        print("----------++++++----")
        remainingSeconds -= 1
    }
}

extension APCollectionDisposeViewController:
    APUnionHttpResultDelegate {
    
    func ap_unionHttpTranResultSuccess(result: APQueryQuickPayResultResponse) {
        if result.transStatus == "2" ||
            result.transStatus == "0" {
            self.dismiss(animated: true) {
                self.endTime()
                NotificationCenter.default.post(Notification.init(name: self.TRAN_DISPOSE_NOTIF_KEY,  object: result, userInfo: nil))
            }
        }
        else {
            httpResult()
        }
    }
    
    func ap_unionHttpTranResultFailure() {
        httpResult()
    }
}













