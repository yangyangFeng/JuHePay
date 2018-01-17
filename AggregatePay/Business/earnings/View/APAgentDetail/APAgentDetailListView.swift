//
//  APAgentDetailListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAgentDetailListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource : [APGetUserListRecommendResponse]? = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var title : String?
    
    let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : APAgentDetailListCell = APAgentDetailListCell.cellWithTableView(tableView) as! APAgentDetailListCell
        cell.data = dataSource?[indexPath.row]
      
        cell.agentLevel.text = title
        cell.selectionStyle = .none
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.AP_setupEmpty()
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
//        tableView.mj_footer = APRefreshFooter(refreshingBlock: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                self.tableView.mj_footer.resetNoMoreData()
//            })
//        })
//        tableView.mj_header = APRefreshHeader(refreshingBlock: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//                self.tableView.mj_header.endRefreshing()
//            })
//        })
        tableView.theme_backgroundColor = ["#fff"]
        theme_backgroundColor = ["#fff"]
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class APAgentDetailListCell: UITableViewCell {
    
    var data : APGetUserListRecommendResponse?{
        didSet{

            var name : String = ""
            
            if (data?.realName?.count != 0) {//&& (data?.mobileNo?.count != 0)
                name = APMineHeaderView.securityFiltering(data?.realName, pre: 1, suf: 0) + "  ";
            }
            if (data?.mobileNo?.count != 0) {
                name = name.appending(APMineHeaderView.securityFiltering(data?.mobileNo, pre: 3, suf: 4));
            }
            agentName.text = name;
            registerTime.text = "注册时间: " + (data?.registeDate ?? "")!
            checkStatus.text = (data?.authStatus ?? "")!
        }
    }
    
    
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
            make.width.equalTo(60)
        }
        checkStatus.snp.makeConstraints { (make) in
            make.top.equalTo(agentLevel.snp.bottom).offset(4)
            make.right.equalTo(-20)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
