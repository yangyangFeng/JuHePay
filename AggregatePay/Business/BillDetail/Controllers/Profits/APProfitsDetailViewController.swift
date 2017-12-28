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
    
    var datas: Dictionary<String, Any>?
    
    var detail: APQueryAccountRecordListDetail? {
        willSet {
            datas = newValue?.mj_keyValues() as? Dictionary<String, Any>
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.status.isHidden = true
    }
    
    override func numberRow(tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func cellAttribute(billDetailCell: APBillDetailCell, indexPath: IndexPath) {
        let title: String = titles.object(at: indexPath.row) as! String
        let key: String = keys.object(at: indexPath.row) as! String
        billDetailCell.titleLabel.text = title
        if key == "amount" {
            let amountNum = Double(datas?[key] as! String)! / 100.00
            billDetailCell.contentLabel.text = String(format: "%.2f", amountNum)
        }
        else {
            billDetailCell.contentLabel.text = datas?[key] as? String
        }
    }
    
    lazy var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["交易时间", "交易金额", "交易流水号", "交易类型"])
        return arr
    }()
    lazy var keys : NSArray = {
        var arr : NSArray = NSArray(array: ["traceDate", "amount", "traceNo", "traceType"])
        return arr
    }()
    /*
     //": 40, //主键
     @objc dynamic var id: String?
     //": 2000,//交易金额
     @objc dynamic var amount: String?
     //": "2017-12-25 03:47:06"//交易日期,
     @objc dynamic var traceDate: String?
     //": "差额",//交易类型
     @objc dynamic var traceType: String?
     //": "0000000020",//流水号
     @objc dynamic var traceNo: String?
     //": 3000,//余额
     @objc dynamic var endAmount: String?
     //": 2//支付模式
     @objc dynamic var payMothed: String?
     
     */
}
