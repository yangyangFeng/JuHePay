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
class APWalletDetailViewController: APBaseViewController,
UITableViewDelegate,
UITableViewDataSource {
    
    let queryAccountRecordRequest = APQueryAccountRecordRequest()
    var datas = [APQueryAccountRecordListDetail]()
    
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

    //初始化网络请求相关
    private func initHttpRequest() {
        weak var weakSelf = self
        
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.datas.removeAll()
            weakSelf?.tableView.mj_footer.resetNoMoreData()
            weakSelf?.queryAccountRecordRequest.pageNo = 1
            weakSelf?.httpQueryAccountRecord()
        })
        tableView.mj_footer = APRefreshFooter(refreshingBlock: {
            weakSelf?.queryAccountRecordRequest.pageNo += 1
            weakSelf?.httpQueryAccountRecord()
        })
        view.AP_loadingBegin()
        httpQueryAccountRecord()
    }
    
    //网络请求
    private func httpQueryAccountRecord () {
        
        queryAccountRecordRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl,
                          action: APHttpService.queryAccountRecord,
                          params: queryAccountRecordRequest,
                          aClass: APQueryAccountRecordResponse.self,
                          success: { (baseResp) in
                            let result = baseResp as! APQueryAccountRecordResponse
                            self.datas.append(contentsOf: result.list!)
                            self.tableView.mj_header.endRefreshing()
                            self.tableView.mj_footer.endRefreshing()
                            if result.list!.count < 10 &&
                               self.queryAccountRecordRequest.pageNo != 1 {
                                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                            }
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
    
    //MARK: ---- delegate
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletDetailCell = APWalletDetailListCell.cellWithTableView(tableView) as! APWalletDetailListCell
        let detail = self.datas[indexPath.row] as APQueryAccountRecordListDetail
        walletDetailCell.titleLabel.text = detail.traceType
        walletDetailCell.amountLabel.text = String(Float(detail.endAmount!)! / 100.0)
        walletDetailCell.dateLabel.text = detail.traceDate
        return walletDetailCell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let detailVC = APProfitsDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
