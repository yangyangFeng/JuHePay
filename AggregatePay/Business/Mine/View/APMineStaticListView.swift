//
//  APMineStaticListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APMineStaticListView: UIView, UITableViewDelegate {

//    let tableView : UITableView
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        tableView = UITableView(frame: CGRect.zero, style: .plain)
//        tableView.delegate = self
////        tableView.dataSource = self
//        tableView.tableFooterView = UIView()
//        tableView.separatorStyle = .none
//
//        addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 10
        }
        else
        {
            return 40
        }
    }
}
