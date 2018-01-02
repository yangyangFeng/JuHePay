//
//  APTradingQueryViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APTradingQueryViewController: APBaseQueryViewController {
    
    let getMyAccountRequest = APGetMyAccountRequest()

    var datas = [APGetMyAccountDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(APTradingQueryCell.self, forCellReuseIdentifier: "APTradingQueryCell")
        startHttpGetAccount()
    }
    
    public func queryButAction() {
        view.AP_loadingBegin()
        self.datas.removeAll()
        self.getMyAccountRequest.pageNo = "1"
        self.tableView.mj_footer.resetNoMoreData()
        httpGetAccount()
    }
    
    
    override func ap_tableView(tableView: UITableView, section: Int) -> Int {
        return datas.count
    }
    
    override func ap_tableView(tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tradingQueryCell = APTradingQueryCell.cellWithTableView(tableView) as! APTradingQueryCell
        let detail = datas[indexPath.row]
        tradingQueryCell.displayGetMyAccountDetail(detail: detail)
        return tradingQueryCell
    }
    
    override func ap_tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension APTradingQueryViewController {
    
    //初始化下拉刷新下拉加载控件和初始请求数据
    func startHttpGetAccount() {
        getMyAccountRequest.pageNo = "1"
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            self.datas.removeAll()
            self.getMyAccountRequest.pageNo = "1"
            self.tableView.mj_footer.resetNoMoreData()
            self.httpGetAccount()
        })
        tableView.mj_footer = APRefreshFooter(refreshingBlock: {
            self.httpGetAccount()
        })
    }
    
    //发起网络请求
    func httpGetAccount() {
    
        getMyAccountRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        getMyAccountRequest.startDate = ap_getStartDate()
        getMyAccountRequest.endDate = ap_getEndDate()
        getMyAccountRequest.payModel = ap_getPaymentWay()
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.getMyAccount, params: getMyAccountRequest, aClass: APGetMyAccountResponse.self, success: { (baseResp) in
            self.httpDisposeDataResponse(response: baseResp as! APGetMyAccountResponse)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.view.AP_loadingEnd()
        }, failure: {(baseError) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    //处理网络请求响应报文
    func httpDisposeDataResponse(response: APGetMyAccountResponse) {
        summaryDataView.leftBottomView.title.text = response.amount
        summaryDataView.rightBottomView.title.text = response.count
        /**
         * 数据上拉加载时
         * 如果当前是最后一页则控制上拉加载控件为没有更多数据可用状态
         */
        if getMyAccountRequest.pageNo == response.totalRecords {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        getMyAccountRequest.pageNo = response.bottomPageNo
        datas.append(contentsOf: response.list!)
        tableView.reloadData()
    }

}


