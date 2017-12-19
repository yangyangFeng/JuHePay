//
//  APCollectionPlaceCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionPlaceCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13.0)
        view.theme_textColor = ["#7a7a7a"]
        view.textAlignment = .left
        return view
    }()
    
    lazy var rateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.theme_textColor = ["#d09326"]
        view.textAlignment = .left
        return view
    }()
    
    lazy var arronImageView: UIImageView = {
        let view = UIImageView()
        view.theme_image = ["wallet_arron_right_icon"]
        view.contentMode = .scaleAspectFit
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
        let identifier = "APCollectionPlaceCell"
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
        addSubview(titleLabel)
        addSubview(rateLabel)
        addSubview(arronImageView)
        addSubview(lineImageView)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(100)
        }
        
        arronImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 15, height: 15))
            
        }
        
        rateLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalTo(arronImageView.snp.left).offset(-10)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        lineImageView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
