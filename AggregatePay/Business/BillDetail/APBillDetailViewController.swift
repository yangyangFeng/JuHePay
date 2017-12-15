//
//  APBillDetailsViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBillDetailViewController: APBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: ---- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "交易详情"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.theme_backgroundColor = ["#fafafa"]
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //MARK: ---- 子类重载
    
    func numberRow(tableView: UITableView) -> Int {
        return 0
    }
    
    func cellAttribute(billDetailCell: APBillDetailCell, indexPath: IndexPath) {
        
    }
    
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRow(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let billDetailCell: APBillDetailCell = APBillDetailCell.cellWithTableView(tableView) as! APBillDetailCell
        if  indexPath.row%2 == 0 {
            billDetailCell.backgroundColor = UIColor.white
            billDetailCell.contentView.backgroundColor = UIColor.white
        }
        else {
            billDetailCell.theme_backgroundColor = ["#fafafa"]
            billDetailCell.contentView.theme_backgroundColor = ["#fafafa"]
        }
        cellAttribute(billDetailCell: billDetailCell, indexPath: indexPath)
        return billDetailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    //MARK: ---- 懒加载
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APBillDetailCell.self, forCellReuseIdentifier: "APBillDetailCell")
        return view
    }()
    
    lazy var headerView: APBillDetailHeaderView = {
        let view = APBillDetailHeaderView()
        return view
    }()
}










