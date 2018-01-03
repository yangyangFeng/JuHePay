//
//  APSelectCreditCardViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit


/**
 * 选择信用卡
 */
class APSelectCreditCardViewController: APBaseViewController,
UITableViewDelegate,
UITableViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择银行卡"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.backgroundColor = UIColor.groupTableViewBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        weak var weakSelf = self
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.startHttpRequest()
        })
        view.AP_loadingBegin()
    }
    
    
    func startHttpRequest() {
        tableView.mj_header.endRefreshing()
        view.AP_loadingEnd()
        tableView.reloadData()
    }
    
    //MARK: ---- delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectCreditCardCell: APSelectCreditCardCell = APSelectCreditCardCell.cellWithTableView(tableView) as! APSelectCreditCardCell
        return selectCreditCardCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
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
        view.register(APSelectCreditCardCell.self,
                      forCellReuseIdentifier: "APSelectCreditCardCell")
        return view
    }()
    
    
}










