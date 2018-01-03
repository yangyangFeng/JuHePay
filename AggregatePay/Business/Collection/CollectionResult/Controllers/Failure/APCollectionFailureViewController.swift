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
    }

    //MARK: ---- 子类重载
    
    override func numberRow(tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func cellAttribute(collectionResultCell: APCollectionResultCell,
                                indexPath: IndexPath) {
        let title: String = titles.object(at: indexPath.row) as! String
        let key: String = keys.object(at: indexPath.row) as! String
        collectionResultCell.titleLabel.text = title
        collectionResultCell.contentLabel.text = resultDic?[key]
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
