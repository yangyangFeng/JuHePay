//
//  APCollectionDisposeViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionDisposeViewController: APCollectionResultViewController {

    //MARK: ---- 子类重载
    
    override func numberRow(tableView: UITableView) -> Int {
        return 1
    }

    override func ap_tableView(tableView: UITableView, cellForRowAtIndexPath: IndexPath) -> UITableViewCell {
        let cell = APCollectionDisposeCell.cellWithTableView(tableView) as! APCollectionDisposeCell
        cell.titleLabel.text = "请稍后再“账单”中查询结果"
        return cell
    }
    
}
