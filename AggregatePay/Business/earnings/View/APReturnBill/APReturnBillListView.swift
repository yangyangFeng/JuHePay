//
//  APReturnBillListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APReturnBillListView: UIView,UITableViewDataSource,UITableViewDelegate {
    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.separatorStyle = .none
        let headview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 10))
        view.tableHeaderView = headview
        view.tableFooterView = UIView()
        view.AP_setupEmpty()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    weak var delegate : AP_TableViewDidSelectProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = APReturnBillListViewCell.cellWithTableView(tableView) as! APReturnBillListViewCell
        cell.selectionStyle = .none
        cell.dateLabel.text = "11/19"
        cell.moneyLabel.text = "¥0.01"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.AP_TableViewDidSelect?(indexPath, obj: "nil")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class APReturnBillListViewCell: UITableViewCell {
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APReturnBillListViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = APReturnBillListViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    let dateLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#999999"]
        return view
    }()
    
    let moneyLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#484848"]
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let line = UIView()
        line.theme_backgroundColor = [AP_TableViewBackgroundColor]
        
        contentView.addSubview(line)
        contentView.addSubview(dateLabel)
        contentView.addSubview(moneyLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.left.equalTo(20)
        }
        moneyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.right.equalTo(-21)
        }
        line.snp.makeConstraints { (make) in
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
