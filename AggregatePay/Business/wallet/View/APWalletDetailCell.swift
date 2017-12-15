//
//  APWalletDetailCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APWalletDetailCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "wallet_withdraw_cell_icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        view.text = "提现"
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .center
        view.text = "¥+0.30"
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let text: String = "20170619\n193420"
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.theme_textColor = ["#9c9b99"]
        view.textAlignment = .right
        view.numberOfLines = 0
        view.text = text
        return view
    }()
    
    lazy var lineImageView: UIImageView = {
        let view = UIImageView()
        view.theme_backgroundColor = ["#e8e8e8"]
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    //MARK: ---- 生命周期
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APWalletDetailCell"
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
        self.contentView.backgroundColor = UIColor.white
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(amountLabel)
        addSubview(dateLabel)
        addSubview(lineImageView)
        
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        dateLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(dateLabel.snp.left).offset(-5)
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.right.equalTo(amountLabel.snp.left)
        }
        lineImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp.left)
            make.right.equalTo(dateLabel.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
