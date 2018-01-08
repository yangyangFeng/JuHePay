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

    override func numberRow(tableView: UITableView) -> Int {
        return titles().count
    }
    
    override func ap_tableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = APCollectionResultCell.cellWithTableView(tableView) as! APCollectionResultCell
        let title: String = titles()[indexPath.row]
        let key: String = keys()[indexPath.row]
        cell.titleLabel.text = title
        let value = resultDic![key]
        if key == "payServiceCode" {
            switch value {
            case "WECHATPAY"?:
                cell.contentLabel.text = "微信收款"
            case "ALIPAY"?:
                cell.contentLabel.text = "支付宝收款"
            case "UNIONPAYPAY"?://无积分
                cell.contentLabel.text = "银联快捷收款"
            case "UNIONPAYGIFTPAY"?:  //积分
                cell.contentLabel.text = "银联快捷收款"
            default:
                cell.contentLabel.text = "二维码收款"
            }
        }
        else if key == "transAmount" {
            let amountNum = Double(value!)! / 100.00
            cell.contentLabel.text = String(format: "%.2f", amountNum)
        }
        else {
            cell.contentLabel.text = value
        }
        
        return cell
    }

    func titles() -> [ String] {
        return ["订单号",
                "交易时间",
                "交易金额",
                "交易类型"]
    }
    func keys() -> [ String] {
        return ["orderNo",
                "transDateTime",
                "transAmount",
                "payServiceCode"]
    }

}







