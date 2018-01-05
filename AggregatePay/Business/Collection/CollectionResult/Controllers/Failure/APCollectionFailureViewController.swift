//
//  APCollectionFailureViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionFailureViewController: APCollectionResultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headerImageView.theme_image = ["collection_failure_icon"]
        headerTitleLabel.text = "收款失败"
        tableView.register(APCollectionResultCell.self, forCellReuseIdentifier: "APCollectionResultCell")
    }

    //MARK: ---- 子类重载
    
    override func numberRow(tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func ap_tableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = APCollectionResultCell.cellWithTableView(tableView) as! APCollectionResultCell
        let title: String = titles.object(at: indexPath.row) as! String
        let key: String = keys.object(at: indexPath.row) as! String
        cell.titleLabel.text = title
        cell.contentLabel.text = resultDic?[key]
        return cell
    }
    
    var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["失败原因"])
        return arr
    }()
    
    var keys : NSArray = {
        var arr : NSArray = NSArray(array: ["respDesc"])
        return arr
    }()

}
