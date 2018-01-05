//
//  APCollectionSuccessViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionSuccessViewController: APCollectionResultViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(APCollectionResultCell.self, forCellReuseIdentifier: "APCollectionResultCell")
        headerImageView.theme_image = ["collection_success_icon"]
        headerTitleLabel.text = "收款成功"
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
        let value = resultDic![key] as! String
        if key == "payServiceCode" {
            switch value {
            case "WECHAT_PAY":
                cell.contentLabel.text = "微信收款"
            case "ALI_PAY":
                cell.contentLabel.text = "支付宝收款"
            case "UnioppayQuick":
                cell.contentLabel.text = "银联快捷收款"
            default:
                cell.contentLabel.text = "二维码收款"
            }
        }
        else if key == "transAmount" {
            let amountNum = Double(value)! / 100.00
            cell.contentLabel.text = String(format: "%.2f", amountNum)
        }
        else {
            cell.contentLabel.text = value
        }
        
        return cell
    }
   
    var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["订单号",
                                            "交易时间",
                                            "交易金额",
                                            "交易类型"])
        return arr
    }()
    var keys : NSArray = {
        var arr : NSArray = NSArray(array: ["orderNo",
                                            "transDateTime",
                                            "transAmount",
                                            "payServiceCode"])
        return arr
    }()

}







