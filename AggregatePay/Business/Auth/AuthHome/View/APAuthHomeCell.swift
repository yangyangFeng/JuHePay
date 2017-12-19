//
//  APAuthHomeCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHomeCell: UITableViewCell {
    
   fileprivate let authNameLabel = UILabel()
   fileprivate let authStatusLabel = UILabel()
    
    var auth: APAuth? {
        didSet {
            if let auth = auth {
                authNameLabel.text = auth.name
                authStatusLabel.text = auth.desc
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutViews()
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
    
    // MARK: -- UI
   private func layoutViews() {
        
        accessoryView = UIImageView.init(image: UIImage.init(named: "auth_authHome_accessory"))
        
        authNameLabel.font = UIFont.systemFont(ofSize: 16)
        authNameLabel.theme_textColor = ["#484848"]
        authStatusLabel.font = UIFont.systemFont(ofSize: 14)
        authStatusLabel.theme_textColor = ["#d09326"]
        
        contentView.addSubview(authNameLabel)
        contentView.addSubview(authStatusLabel)
        
        authNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        authStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-34)
        }
    }
}
