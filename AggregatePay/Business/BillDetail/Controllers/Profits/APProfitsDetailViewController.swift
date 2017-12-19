//
//  APProfitsDetailViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 分润查询详情
 */
class APProfitsDetailViewController: APBillDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberRow(tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func cellAttribute(billDetailCell: APBillDetailCell, indexPath: IndexPath) {
        let title: String = titles.object(at: indexPath.row) as! String
        let data: String = datas.object(at: indexPath.row) as! String
        billDetailCell.titleLabel.text = title
        billDetailCell.contentLabel.text = data
    }
    
    var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["交易时间", "交易金额", "交易流水号", "交易类型"])
        return arr
    }()
    var datas : NSArray = {
        var arr : NSArray = NSArray(array: ["2017/11/03  11:12:22", "6.20", "108523", "下级分润"])
        return arr
    }()
    
}
