//
//  APSettingCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSettingCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        return view
    }()
    
    
    lazy var describeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10.0)
        view.theme_textColor = ["#acacac"]
        view.textAlignment = .left
        return view
    }()
    
    lazy var arronImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.theme_image = ["wallet_arron_right_icon"]
        return view
    }()
    
    lazy var lineImageView: UIImageView = {
        let view = UIImageView()
        view.theme_backgroundColor = ["#e8e8e8"]
        view.contentMode = .scaleAspectFit
        return view
    }()

    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APSettingCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        guard let newCell = cell else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        
        addSubview(titleLabel)
        addSubview(describeLabel)
        addSubview(arronImageView)
        addSubview(lineImageView)
        
        arronImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(20)
        }
        describeLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel.snp.left)
        }
        lineImageView.snp.makeConstraints { (make) -> Void in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
