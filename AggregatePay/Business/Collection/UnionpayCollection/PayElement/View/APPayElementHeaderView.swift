//
//  APPayEssentialHeaderView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 输入支付要素子视图（头部）
 */
class APPayElementHeaderView: UIView {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#999999"]
        view.textAlignment = .left
        view.text = "交易金额"
        return view
    }()
    
    lazy var payEssentialLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#999999"]
        view.textAlignment = .left
        view.text = "收款通道"
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.text = "500.00元"
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

    lazy var payEssentialTextLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        return view
    }()
    
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        
        addSubview(titleLabel)
        addSubview(amountLabel)
        addSubview(payEssentialLabel)
        addSubview(payEssentialTextLabel)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(15)
        }
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        payEssentialLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(amountLabel.snp.bottom).offset(5)
        }
        
        payEssentialTextLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(payEssentialLabel.snp.right).offset(5)
            make.centerY.equalTo(payEssentialLabel.snp.centerY)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
