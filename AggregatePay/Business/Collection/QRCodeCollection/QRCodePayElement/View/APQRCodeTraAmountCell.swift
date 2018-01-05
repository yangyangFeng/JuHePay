//
//  APQRCodeTraAmountCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码交易金额
 */
class APQRCodeTraAmountCell: APBaseFormsCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "交易金额"
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#999999"]
        view.textAlignment = .left
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.text = "0.00"
        view.textAlignment = .center
        view.theme_textColor = ["#422f02"]
        view.backgroundColor = UIColor.clear
        if #available(iOS 8.2, *) {
            view.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: -0.8))
        }
        else {
            view.font = UIFont.systemFont(ofSize: 36)
        }
        return view
    }()
    lazy var dollarLabel: UILabel = {
        let view = UILabel()
        view.text = "元"
        view.textAlignment = .center
        view.theme_textColor = ["#422f02"]
        view.backgroundColor = UIColor.clear
        if #available(iOS 8.2, *) {
            view.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: -0.8))
        }
        else {
            view.font = UIFont.systemFont(ofSize: 36)
        }
        return view
    }()
    
    override init() {
        super.init()
        backgroundColor = UIColor.white
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(dollarLabel)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.top.equalTo(self.snp.top).offset(20)
            maker.height.equalTo(20)
        }
        textLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.top.equalTo(titleLabel.snp.bottom).offset(20)
            maker.height.equalTo(30)
        }
        dollarLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(textLabel.snp.right).offset(20)
            maker.top.equalTo(titleLabel.snp.bottom).offset(20)
            maker.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
