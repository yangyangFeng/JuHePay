//
//  APAgentDetailListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAgentDetailListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = APAgentDetailListCell.cellWithTableView(tableView)
        cell?.selectionStyle = .none
        return cell!
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.AP_setupEmpty()
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        tableView.theme_backgroundColor = ["#fff"]
        theme_backgroundColor = ["#fff"]
    }

    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class APAgentDetailListCell: UITableViewCell {
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APAgentDetailListCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = APAgentDetailListCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    let agentName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.theme_textColor = ["#484848"]
        label.textAlignment = .left
        return label
    }()
    
    let registerTime : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.theme_textColor = ["#9c9b99"]
        label.textAlignment = .left
        return label
    }()
    
    let agentLevel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.theme_textColor = ["#484848"]
        label.textAlignment = .right
        return label
    }()
    
    let checkStatus : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.theme_textColor = ["#9c9b99"]
        label.textAlignment = .right
        return label
    }()
    
    let bottomLine : UIView = {
        let view = UIView()
        view.theme_backgroundColor = ["#e8e8e8"]
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        agentName.text = "王**  135****8767"
        registerTime.text = "注册时间：2017/11／12  11:21:11"
        agentLevel.text = "青铜"
        checkStatus.text = "已实名"
        
        contentView.addSubview(agentName)
        contentView.addSubview(registerTime)
        contentView.addSubview(agentLevel)
        contentView.addSubview(checkStatus)
        contentView.addSubview(bottomLine)
        
        agentName.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(20)
        }
        registerTime.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-13)
        }
        agentLevel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.right.equalTo(-20)
            make.width.equalTo(30)
        }
        checkStatus.snp.makeConstraints { (make) in
            make.top.equalTo(agentLevel.snp.bottom).offset(4)
            make.right.equalTo(-20)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(2)
            make.bottom.equalTo(0)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
