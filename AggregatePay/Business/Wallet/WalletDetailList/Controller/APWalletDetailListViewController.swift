//
//  APWalletDetailViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 钱包明细列表
 */
class APWalletDetailViewController: APBaseViewController{
    
    var amountSum: String?
    
    let queryAccountRecordRequest = APQueryAccountRecordRequest()
    
    var datas = [APQueryAccountRecordListDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "钱包明细"
        createSubViews()
        initHttpRequest()
    }
   
    //MARK: ---- lazy loading
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.AP_setupEmpty()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APWalletDetailListCell.self, forCellReuseIdentifier: "APWalletDetailListCell")
        return view
    }()
}

//MARK: --- Extension

extension APWalletDetailViewController {
    
    //MARK: ---- private
    private func createSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }

    private func initHttpRequest() {
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            self.datas.removeAll()
            self.queryAccountRecordRequest.pageNo = "1"
            self.tableView.mj_footer.resetNoMoreData()
            self.httpQueryAccountRecord()
        })
        tableView.mj_footer = APRefreshFooter(refreshingBlock: {
            self.httpQueryAccountRecord()
        })
        view.AP_loadingBegin()
        queryAccountRecordRequest.pageNo = "1"
        httpQueryAccountRecord()
    }
    
    private func httpQueryAccountRecord () {
//        queryAccountRecordRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.queryAccountRecord, params: queryAccountRecordRequest, aClass: APQueryAccountRecordResponse.self, success: { (baseResp) in
            self.view.AP_loadingEnd()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.httpDisposeDataResponse(response: baseResp as! APQueryAccountRecordResponse)
        }) { (baseError) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        }
    }
    
    private func httpDisposeDataResponse(response: APQueryAccountRecordResponse) {
        if queryAccountRecordRequest.pageNo == response.bottomPageNo {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        queryAccountRecordRequest.pageNo = response.bottomPageNo!
        datas.append(contentsOf: response.list!)
        tableView.reloadData()
    }
}

extension APWalletDetailViewController:
    UITableViewDelegate,
    UITableViewDataSource   {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletDetailCell = APWalletDetailListCell.cellWithTableView(tableView) as! APWalletDetailListCell
        let detail = datas[indexPath.row]
        walletDetailCell.displayQueryAccountRecordListDetail(detail: detail)
        return walletDetailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = datas[indexPath.row]
        if detail.traceType == "提现" {
            pushWithdrawDetailVC(detail: detail)
        }
        else if detail.traceType == "下级分润" {
            pushProfitsDetailVC(detail: detail)
        }
        else {
            pushProfitsDetailVC(detail: detail)
        }
    }
    
    func pushWithdrawDetailVC(detail: APQueryAccountRecordListDetail) {
        let withdrawDetailVC = APWithdrawDetailViewController()
        withdrawDetailVC.detail = detail
        withdrawDetailVC.amountSum = amountSum
        navigationController?.pushViewController(withdrawDetailVC, animated: true)
    }
    
    func pushProfitsDetailVC(detail: APQueryAccountRecordListDetail) {
        let profitsDetailVC = APProfitsDetailViewController()
        profitsDetailVC.detail = detail
        profitsDetailVC.amountSum = amountSum
        navigationController?.pushViewController(profitsDetailVC, animated: true)
    }
}




