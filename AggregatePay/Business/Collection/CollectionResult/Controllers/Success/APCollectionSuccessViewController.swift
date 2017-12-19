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
        headerImageView.theme_image = ["collection_success_icon"]
        headerTitleLabel.text = "收款成功"
    }

    //MARK: ---- 子类重载
    
    override func numberRow(tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func cellAttribute(collectionResultCell: APCollectionResultCell,
                                indexPath: IndexPath) {
        let title: String = titles.object(at: indexPath.row) as! String
        let data: String = datas.object(at: indexPath.row) as! String
        collectionResultCell.titleLabel.text = title
        collectionResultCell.contentLabel.text = data
    }
    
    var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["订单号",
                                            "商户编号",
                                            "交易时间",
                                            "交易金额",
                                            "手续费",
                                            "交易类型"])
        return arr
    }()
    var datas : NSArray = {
        var arr : NSArray = NSArray(array: ["1300000221244",
                                            "80087655511",
                                            "2017/03/08  00:05:21",
                                            "400.00元",
                                            "1.00元",
                                            "银联快捷"])
        return arr
    }()

}







