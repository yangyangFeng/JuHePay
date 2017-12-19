//
//  APReturnBillViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
//import APRefreshHeader
class APReturnBillViewController: APBaseViewController,AP_TableViewDidSelectProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "账单"
        
        initSubviews()
        // Do any additional setup after loading the view.
    }
    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        print(indexPath)
    }
    
    func initSubviews(){
        let searchBar = APReturnBillSearchBar()
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(104)
        }
        let listView = APReturnBillListView()
        listView.tableView.mj_header = APRefreshHeader.init(refreshingBlock: {
            listView.tableView.mj_header.endRefreshing()
        })
        listView.delegate = self
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(searchBar.snp.bottom).offset(0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
