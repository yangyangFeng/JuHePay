//
//  APCollectionDisposeViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionDisposeViewController: APCollectionResultViewController {
    
    let datas = ["请稍后再“账单”中查询结果"]

    override func viewDidLoad() {
        super.viewDidLoad()
        headerImageView.theme_image = ["collection_failure_icon"]
        headerTitleLabel.text = "未查询到交易结果"
        tableView.register(APCollectionDisposeCell.self, forCellReuseIdentifier: "APCollectionDisposeCell")
        
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
    
    
}










