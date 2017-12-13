//
//  APAuthHomeCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHomeCell: UITableViewCell {
    
   private let authNameLabel = UILabel()
   private let authStatusLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellWithTableView(_ tableView: UITableView) -> APAuthHomeCell? {
        
        let reuseIdentifier = NSStringFromClass(self)
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        guard let newCell = cell else {
            cell = APAuthHomeCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
            return cell as? APAuthHomeCell
        }
        return newCell as? APAuthHomeCell
    }
    
    func setUpUI() {
        
        accessoryView = UIImageView.init(image: UIImage.init(named: "auth_authHome_accessory"))
        
        authNameLabel.font = UIFont.systemFont(ofSize: 14)
        authNameLabel.theme_textColor = ["#484848"]
        authStatusLabel.font = UIFont.systemFont(ofSize: 12)
        authStatusLabel.theme_textColor = ["#d09326"]
        
        contentView.addSubview(authNameLabel)
        contentView.addSubview(authStatusLabel)
        
        authNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(authNameLabel.superview!)
            make.left.equalTo(authNameLabel.superview!).offset(15)
        }
        authStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(authStatusLabel.superview!)
            make.right.equalTo(authStatusLabel.superview!).offset(-34)
        }
    }
    
    var authHomeModel: APAuthHomeModel? {
        didSet{
            authNameLabel.text = authHomeModel?.authName
            authStatusLabel.text = String(describing: authHomeModel?.authStatus)
        }
    }
}
