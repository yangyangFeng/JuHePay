//
//  APBillDetailHeaderView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBillDetailHeaderView: UIView {
    
    lazy var status: UIButton = {
        let view = UIButton()
        view.contentHorizontalAlignment = .right
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.theme_setImage(["bill_detail_success_icon"], forState: .normal)
        view.setTitle(" 成功", for: .normal)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#999999"]
        view.textAlignment = .left
        view.text = "钱包余额(元)"
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.text = "0.00"
        view.textAlignment = .center
        view.theme_textColor = ["#422f02"]
        if #available(iOS 8.2, *) {
            view.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: -0.8))
        }
        else {
            view.font = UIFont.systemFont(ofSize: 36)
        }
        return view
    }()

    init() {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white
        
        addSubview(status)
        addSubview(titleLabel)
        addSubview(amountLabel)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(20)
        }
        status.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
