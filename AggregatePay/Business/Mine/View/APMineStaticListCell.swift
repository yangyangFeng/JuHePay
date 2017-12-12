//
//  APMineStaticListCell.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

let Service_tel = "400-666-888"

class APMineStaticListCell: UITableViewCell {

    let leftIcon = UIImageView()
    let title = UILabel()
    let arrow = UIImageView()
    let telButton = UIButton(type: UIButtonType.custom)
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let bottomLine = UIView()
        bottomLine.theme_backgroundColor = ["#e8e8e8"]
        
        title.font = UIFont.systemFont(ofSize: 14)
        title.theme_textColor = ["#484848"]
        title.textAlignment = .left
        
        telButton.theme_setTitleColor(["#999999"], forState: UIControlState.normal)
        telButton.setTitle(Service_tel, for: UIControlState.normal)
        telButton.titleLabel?.textAlignment = .right
        
        arrow.theme_image = ["Mine_head_arrow"]
        
        contentView.addSubview(title)
        contentView.addSubview(telButton)
        contentView.addSubview(leftIcon)
        contentView.addSubview(bottomLine)
        
        leftIcon.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.left.equalTo(22)
        }
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftIcon.snp.right).offset(0)
            make.left.equalTo(leftIcon.snp.right).offset(10)
        }
        arrow.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.right.equalTo(-19)
        }
        telButton.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
