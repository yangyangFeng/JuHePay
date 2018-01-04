//
//  APMineStaticListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

protocol APMineStaticListViewDelegate : NSObjectProtocol {
    func tableViewDidSelectIndex(_ title : String, controller : String , level : Int)
}

class APMineStaticListView: UIView, UITableViewDataSource, UITableViewDelegate {

    weak var delegate : APMineStaticListViewDelegate?
    
    let tableView : UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
    var listDataSource : NSArray = {
        let path = Bundle.main.path(forResource: "Mine_List_Config", ofType: "plist")
        var arr : NSArray = NSArray(contentsOfFile: path!)!
        return arr
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = [AP_TableViewBackgroundColor]
        tableView.theme_backgroundColor = ["#FFF"]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(APMineStaticListCell.self, forCellReuseIdentifier: "APMineStaticListCell")
//        tableView.bounces = false
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            
        })
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
            return listDataSource.count
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
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell : APMineStaticListCell = APMineStaticListCell.cellWithTableView(tableView) as! APMineStaticListCell
            cell.selectionStyle = .none
            
            let item : NSDictionary = listDataSource[indexPath.row] as! NSDictionary
            
            let title = item.object(forKey: "title")
            cell.title.text = title as? String
            
            let icon = item.object(forKey: "icon")
            cell.leftIcon.theme_image = [icon as! String]
            
            if cell.title.text == "客服"
            {
                cell.telButton.isHidden = false
                cell.telButton.setTitle("400-666-888", for: UIControlState.normal)
            }
            else
            {
                cell.telButton.isHidden = true
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let _delegate = delegate else {
            print("未设置Delegate")
            return
        }
        let item : NSDictionary = listDataSource[indexPath.row] as! NSDictionary
        let controller = item.object(forKey: "controller")
        let title = item.object(forKey: "title")
        _delegate.tableViewDidSelectIndex(title as! String, controller: controller as! String , level: Int(truncating: item.object(forKey: "level") as! NSNumber))
    }
}
