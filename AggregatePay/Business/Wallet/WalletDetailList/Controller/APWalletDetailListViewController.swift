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
    
    @objc dynamic var datas = NSMutableArray()
    
    //MARK: ---- life cycle
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
            self.datas.removeAllObjects()
            self.tableView.mj_footer.resetNoMoreData()
            self.queryAccountRecordRequest.pageNo = "1"
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
        queryAccountRecordRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl,
                          action: APHttpService.queryAccountRecord,
                          params: queryAccountRecordRequest,
                          aClass: APQueryAccountRecordResponse.self,
                          success: { (baseResp) in
                            let result = baseResp as! APQueryAccountRecordResponse
                            self.httpMergingResponseData(result: result)
                            self.tableView.mj_header.endRefreshing()
                            self.tableView.mj_footer.endRefreshing()
                            self.tableView.reloadData()
                            self.view.AP_loadingEnd()
        }) { (baseError) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        }
    }
    
    private func httpMergingResponseData(result: APQueryAccountRecordResponse) {
        //合并元素
        let details = APQueryAccountRecordListDetail.mj_objectArray(withKeyValuesArray: result.list as! [Any])
        self.datas.addObjects(from: details as! [Any])
        //判断是否存在数据
        if self.datas.count == 0 {
            self.tableView.AP_setupEmpty()
        }
        //获取下一页页码
        self.queryAccountRecordRequest.pageNo = result.bottomPageNo!
        //验证本次请求结果是否是最后一次
        if self.queryAccountRecordRequest.pageNo == result.totalRecords {
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }
    }
}

extension APWalletDetailViewController:
    UITableViewDelegate,
    UITableViewDataSource   {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletDetailCell = APWalletDetailListCell.cellWithTableView(tableView) as! APWalletDetailListCell
        let detail = self.datas[indexPath.row] as! APQueryAccountRecordListDetail
        let amountNum = Double(detail.endAmount!)! / 100.00
        if detail.traceType == "提现" {
            walletDetailCell.amountLabel.text = String(format: "¥-%.2f", amountNum)
            walletDetailCell.iconImageView.theme_image = ["wallet_withdraw_cell_icon"]
        }
        else if detail.traceType == "下级分润"{
            walletDetailCell.amountLabel.text = String(format: "¥+%.2f", amountNum)
            walletDetailCell.iconImageView.theme_image = ["wallet_profits_cell_icon"]
        }
        else {
            walletDetailCell.amountLabel.text = String(format: "¥+%.2f", amountNum)
            walletDetailCell.iconImageView.theme_image = ["wallet_profits_cell_icon"]
        }
        walletDetailCell.titleLabel.text = detail.traceType
        walletDetailCell.dateLabel.text = detail.traceDate?.replacingOccurrences(of: " ", with: "\n")
        return walletDetailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = self.datas[indexPath.row] as! APQueryAccountRecordListDetail
        if detail.traceType == "提现" {
            let withdrawDetailVC = APWithdrawDetailViewController()
            withdrawDetailVC.detail = detail
            withdrawDetailVC.amountSum = amountSum
            navigationController?.pushViewController(withdrawDetailVC, animated: true)
        }
        else if detail.traceType == "下级分润" {
            let profitsDetailVC = APProfitsDetailViewController()
            profitsDetailVC.detail = detail
            profitsDetailVC.amountSum = amountSum
            navigationController?.pushViewController(profitsDetailVC, animated: true)
        }
        else {
            //给测试数据使用
            let profitsDetailVC = APProfitsDetailViewController()
            profitsDetailVC.detail = detail
            profitsDetailVC.amountSum = amountSum
            navigationController?.pushViewController(profitsDetailVC, animated: true)
        }
        
    }
}




