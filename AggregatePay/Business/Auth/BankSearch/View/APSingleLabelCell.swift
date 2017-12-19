//
//  APSingleLabelCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSingleLabelCell: UITableViewCell {

    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.textColor = UIColor.init(hex6: 0x484848)
        label.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
