//
//  APMineStaticListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APMineStaticListView: UIView, UITableViewDataSource, UITableViewDelegate {

    let tableView : UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(APMineStaticListCell.self, forCellReuseIdentifier: "APMineStaticListCell")
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Mine_tableViewCell_line")
            cell.contentView.backgroundColor = UIColor.groupTableViewBackground
            return cell
        }
        else
        {
            let cell = APMineStaticListCell.cellWithTableView(tableView)
            
            return cell!
        }
        
    }
}
