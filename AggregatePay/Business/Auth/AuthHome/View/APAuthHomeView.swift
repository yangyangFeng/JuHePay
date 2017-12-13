//
//  APAuthHomeView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHomeView: UIView, UITableViewDelegate, UITableViewDataSource {
 
    private let tableView : UITableView = UITableView(frame: CGRect.zero, style: .plain)
    var dataSource: Array<Any> = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(APAuthHomeCell.self, forCellReuseIdentifier: NSStringFromClass(APAuthHomeCell.self))
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = APAuthHomeCell.cellWithTableView(tableView)
        cell?.authHomeModel = dataSource[indexPath.row] as? APAuthHomeModel
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.init()
        cell.layoutMargins = UIEdgeInsets.init()
    }
    
}
