//
//  APTradingDetailViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 交易查询详情
 */
class APTradingDetailViewController: APBillDetailViewController {
    
    var transId: String?
    var tradingDetail: APTradingDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.titleLabel.text = "交易金额(元)"
        startHttpGetTradingDetail()
    }
    
    override func numberRow(tableView: UITableView) -> Int {
        return getTitles().count
    }
    
    override func cellAttribute(billDetailCell: APBillDetailCell, indexPath: IndexPath) {
        let key = getkeys()[indexPath.row]
        var value: String?
        if key == "merchantNo" {
            value = tradingDetail?.merchantNo
        }
        else if key == "merchantName" {
            value = tradingDetail?.merchantName
        }
        else if key == "payModeL" {
            value = tradingDetail?.payModeL
        }
        else if key == "orderNo" {
            value = tradingDetail?.orderNo
        }
        else if key == "terminalNo" {
            value = tradingDetail?.terminalNo
        }
        else if key == "transType" {
            value = tradingDetail?.transType
        }
        else if key == "transDate" {
            value = tradingDetail?.transDate
        }
        billDetailCell.titleLabel.text = getTitles()[indexPath.row]
        billDetailCell.contentLabel.text = value
    }
}

extension APTradingDetailViewController {
    
    func startHttpGetTradingDetail() {
        let tradingDetailRequest = APTradingDetailRequest()
        tradingDetailRequest.userId = APUserDefaultCache.AP_get(key: .userId) as! String
        tradingDetailRequest.transId = transId
        view.AP_loadingBegin()
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl,
                         action: APHttpService.getMyAccountDetails,
                         params: tradingDetailRequest,
                         aClass: APTradingDetailResponse.self,
                         success: { (baseResp) in
                            self.tradingDetail = baseResp as? APTradingDetailResponse
                            self.headerView.amountLabel.text = self.tradingDetail?.transAmount
                            self.tableView.reloadData()
                            self.view.AP_loadingEnd()
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    func getTitles() -> [ String] {
        return ["商户编号",
                "商户名称",
                "收款方式",
                "订单号",
                "终端号",
                "交易类型",
                "交易时间"]
    }
    
    func getkeys() -> [ String] {
        return ["merchantNo",
                "merchantName",
                "payModeL",
                "orderNo",
                "terminalNo",
                "transType",
                "transDate"]
    }
}


class APTradingDetailRequest: APBaseRequest {
    
    @objc dynamic var transId: String?
}


class APTradingDetailResponse: APBaseResponse {

    @objc dynamic var merchantNo: String? // ": " PM0300009646368 ",
    @objc dynamic var merchantName: String?// ": "曹操",
    @objc dynamic var payModeL: String?// ": "微信",
    @objc dynamic var orderNo: String?// ": " 1300000000000009483",
    @objc dynamic var terminalNo: String?// ": " 15005955 ",
    @objc dynamic var transType: String?// ": " wechatPay ",
    @objc dynamic var transDate: String?// ": "2016-12-12 12:12:12",
    @objc dynamic var status: String?// ": "消费",
    @objc dynamic var transAmount: String?// ": "21",
    
}











