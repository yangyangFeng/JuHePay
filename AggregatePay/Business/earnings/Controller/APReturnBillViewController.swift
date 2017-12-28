//
//  APReturnBillViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APReturnBillViewController: APBaseViewController,AP_TableViewDidSelectProtocol {

    var data : APGetProfitHomeResponse?
    
    private let searchBar : APReturnBillSearchBar = APReturnBillSearchBar()
    
    private let listView = APReturnBillListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vhl_setStatusBarStyle(.lightContent)
        
        title = "账单"
        
        initSubviews()
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        print(indexPath)
    }
    
    func AP_Action_Click() {
        listView.page = 1
    }
    
    func initSubviews(){
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(104)
        }
        weak var weakSelf = self
        listView.tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.listView.page = 1
//            print(self.searchBar.AP_statrTimeStr() + self.searchBar.AP_endTimeStr())
            weakSelf?.loadData()
        })
        listView.tableView.mj_footer = APRefreshFooter(refreshingBlock: {
            weakSelf?.listView.page += 1
            weakSelf?.loadData()
//            listView.tableView.mj_footer.endRefreshing()
        })
        listView.delegate = self
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(searchBar.snp.bottom).offset(0)
        }
        
        let queryButton = UIButton.init(type: UIButtonType.system)
        queryButton.setTitle("查询", for: .normal)
        queryButton.theme_setTitleColor(["#c8a556"], forState: .normal)
        queryButton.sizeToFit()
        queryButton.addTarget(self, action: #selector(queryDidAction), for: UIControlEvents.touchUpInside)
        let rightBarItem = UIBarButtonItem.init(customView: queryButton)
        navigationItem.rightBarButtonItem = rightBarItem
    }

    @objc func queryDidAction(){
        loadData()
    }
    
    func loadData()
    {
        view.AP_loadingBegin()
        let param = APGetMyProfitRequest()
        param.startDate = searchBar.AP_statrTimeStr()
        param.endDate = searchBar.AP_endTimeStr()
        param.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        param.pageNo = String(listView.page)
        param.mj_keyValues()
        APEarningsHttpTool.getMyProfit(param, success: { (res) in
            self.view.AP_loadingEnd()
            let resData = res as! APGetMyProfitResponse
            self.listView.tableView.mj_header.endRefreshing()
//            if resda
            self.searchBar.data = resData
            self.listView.data = resData
        }) { (error) in
            self.view.AP_loadingEnd()
            self.listView.tableView.mj_header.endRefreshing()
            self.view.makeToast(error.message)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
