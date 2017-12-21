//
//  APShareListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APShareListView: UIView,UITableViewDelegate,UITableViewDataSource {

    var titles : [String] = ["微信","朋友圈","保存图片"]
    
    let iconNamePre : String = "ShareIcon"
    
    weak var delegate : AP_TableViewDidSelectProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        
        tableView.register(cellWithClass: APShareListCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.theme_backgroundColor = [AP_TableViewBackgroundColor]
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 37
        }
        else{
            return 65
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        }
        else{
            return 3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0 {
            let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "UITableViewCell")
            cell.contentView.addSubview(topTitleLabel)
            cell.contentView.theme_backgroundColor = [AP_TableViewBackgroundColor]
            topTitleLabel.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview().offset(0)
                make.left.equalTo(20)
            })
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withClass: APShareListCell.self)
            let name = iconNamePre+String(indexPath.row)
            
            cell?.imageView?.theme_image = [name]
            cell?.shareType.text = titles[indexPath.row]
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            delegate?.AP_TableViewDidSelect?(indexPath, obj: titles[indexPath.row])
        }
    }
    
    lazy var topTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#d09326"]
        view.text = "请选择图片分享渠道"
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

class APShareListCell: UITableViewCell {
    

    var iconImageView : UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    var shareType : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#7a7a7a"]
        return view
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let line = UIView()
        line.theme_backgroundColor = [AP_TableViewBackgroundColor]
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(shareType)
        contentView.addSubview(line)
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(18)
            make.centerY.equalToSuperview().offset(0)
            make.left.equalTo(23)
        }
        shareType.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalTo(iconImageView.snp.right).offset(11)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
