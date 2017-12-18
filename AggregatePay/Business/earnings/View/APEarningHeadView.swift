//
//  APEarningHeadView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APEarningHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "Earning_head_bg"))
        
        
        let topLabel = UILabel()
        topLabel.text = "累计收益(元)"
        topLabel.font = UIFont.systemFont(ofSize: 12)
        topLabel.theme_textColor = ["#4c370b"]
        
        let moneyLabel = UILabel()
        moneyLabel.text = "0.0"
        moneyLabel.font = UIFont.systemFont(ofSize: 42)
        moneyLabel.textAlignment = .left
        moneyLabel.theme_textColor = ["#7f5e12"]
        
        let bottomLabel = UILabel()
        bottomLabel.text = "昨日收益(元)"
        bottomLabel.theme_textColor = ["#4c370b"]
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        
        let yesterdayMoneyLabel = UILabel()
        yesterdayMoneyLabel.font = UIFont.systemFont(ofSize: 12)
        yesterdayMoneyLabel.theme_textColor = ["#4c370b"]
        yesterdayMoneyLabel.text = "+0.00"
        
        let arrowIcon = UIImageView.init(image: UIImage.init(named: "Mine_head_arrow"))
        
        addSubview(bgImageView)
        addSubview(topLabel)
        addSubview(moneyLabel)
        addSubview(bottomLabel)
        addSubview(yesterdayMoneyLabel)
        addSubview(arrowIcon)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(-64)
            make.left.right.bottom.equalTo(0)
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo((topLabel.superview?.snp.top)!).offset(13)
            make.left.equalTo(20)
            make.height.equalTo(15)
        }
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(7)
            make.left.equalTo(20)
            make.height.equalTo(44)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-23)
            make.left.equalTo(20)
        }
        yesterdayMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLabel.snp.right).offset(20)
            make.centerY.equalTo(bottomLabel.snp.centerY).offset(0)
        }
        arrowIcon.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.right.equalTo(-19)
            make.centerY.equalTo((arrowIcon.superview?.snp.centerY)!).offset(0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
