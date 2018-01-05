//
//  APCollectionDisposeCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionDisposeCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.numberOfLines = 0
        view.theme_textColor = ["#999999"]
        view.textAlignment = .left
        return view
    }()

    //MARK: ---- 生命周期
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APCollectionDisposeCell"
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

        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
