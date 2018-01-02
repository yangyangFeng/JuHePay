//
//  APEarningListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APEarningListView: UIView,UITableViewDataSource,UITableViewDelegate {

    var tableView : UITableView!
    
    weak var delegate : AP_TableViewDidSelectProtocol?
    
    var data : APGetProfitHomeResponse?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView.init(frame: frame, style: UITableViewStyle.plain)

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        theme_backgroundColor = [AP_TableViewBackgroundColor]
        tableView.theme_backgroundColor = [AP_TableViewBackgroundColor]
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
            return data?.getRecommendByUser?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        }
        else
        {
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell : APEarningListViewHeadCell = APEarningListViewHeadCell.cellWithTableView(tableView)
                as! APEarningListViewHeadCell
            if let cellData = data{
                cell.my_agentsLabel.text = "我推广的人：" + (cellData.recommendCount ?? "0")! + "人"
            }
            else{
                cell.my_agentsLabel.text = "我推广的人：0人"
            }

            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell : APEarningListViewCell = APEarningListViewCell.cellWithTableView(tableView) as! APEarningListViewCell
            let cellData = data?.getRecommendByUser?[indexPath.row]
            
            cell.leftIcon.image = UIImage.init(named: "Mine_head_user_level_title_0" )
            cell.levelName.text = cellData?.userLevelName
            cell.subAgents.text = "共有" + (cellData?.userRecommendCount ?? "0")! + "位服务商"
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let cellData = data?.getRecommendByUser?[indexPath.row]
            delegate?.AP_TableViewDidSelect?(indexPath, obj: cellData!)
        }
    }
}

class APEarningListViewCell: UITableViewCell {

    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APEarningListViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = APEarningListViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    let leftIcon = UIImageView()
    let levelName = UILabel()
    let subAgents = UILabel()
    let rightArrow = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.theme_backgroundColor = ["#fff"]
        
//        leftIcon.image = UIImage.init(named: "Mine_head_user_level_title_2")
        rightArrow.image = UIImage.init(named: "Mine_head_arrow")
        
        levelName.text = "王者代理商"
        levelName.font = UIFont.systemFont(ofSize: 14)
        levelName.theme_textColor = ["#484848"]
        levelName.textAlignment = .left
        
        subAgents.font = UIFont.systemFont(ofSize: 10)
        subAgents.theme_textColor = ["#acacac"]
        subAgents.textAlignment = .left
        subAgents.text = "共有0位服务商"
        
        let bottomLine : UIView = {
            let view = UIView()
            view.theme_backgroundColor = [AP_TableViewBackgroundColor]
            return view
        }()
        contentView.addSubview(leftIcon)
        contentView.addSubview(rightArrow)
        contentView.addSubview(levelName)
        contentView.addSubview(subAgents)
        contentView.addSubview(bottomLine)
        
        leftIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            make.left.equalTo(21)
            make.width.height.equalTo(22)
        }
        levelName.snp.makeConstraints { (make) in
            make.left.equalTo(leftIcon.snp.right).offset(20)
            make.top.equalTo(10)
        }
        subAgents.snp.makeConstraints { (make) in
            make.left.equalTo(levelName.snp.left).offset(0)
            make.top.equalTo(levelName.snp.bottom).offset(3)
        }
        rightArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.right.equalTo(-19)
            make.width.equalTo(7)
            make.height.equalTo(12)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class APEarningListViewHeadCell: UITableViewCell {
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APEarningListViewHeadCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = APEarningListViewHeadCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    let my_agentsLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.theme_backgroundColor = [AP_TableViewBackgroundColor]
        
        my_agentsLabel.font = UIFont.systemFont(ofSize: 12)
        my_agentsLabel.theme_textColor = ["#4c370b"]
        my_agentsLabel.text = "我推广的人：5人"
        
        contentView.addSubview(my_agentsLabel)
        my_agentsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.left.equalTo(14)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
