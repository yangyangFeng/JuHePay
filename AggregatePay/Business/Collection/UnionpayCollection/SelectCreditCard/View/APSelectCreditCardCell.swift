//
//  APSelectCreditCardCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSelectCreditCardCell: UITableViewCell {

    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "union_cbank_icon_Logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        view.text = "广发发展银行"
        return view
    }()
    
    lazy var cardTypeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        view.text = "信用卡"
        return view
    }()
    
    lazy var cardLastNo: UILabel = {
        
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.theme_textColor = ["#9c9b99"]
        view.textAlignment = .left
        view.numberOfLines = 0
        view.text = "尾号6139"
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
        let identifier = "APSelectCreditCardCell"
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
        addSubview(cardTypeLabel)
        addSubview(cardLastNo)
        addSubview(lineImageView)
        
        iconImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }

        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalTo(iconImageView.snp.top)
        }

        cardTypeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }

        cardLastNo.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
        }

        lineImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
