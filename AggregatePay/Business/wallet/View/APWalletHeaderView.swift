//
//  APWalletHeaderView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APWalletHeaderView: UIView {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#4c370b"]
        view.textAlignment = .center
        view.text = "可提现余额"
        return view
    }()
    
    lazy var amountIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "wallet_money_icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.text = "0.0"
        view.textAlignment = .center
        view.theme_textColor = ["#7f5e12"]
        if #available(iOS 8.2, *) {
            view.font = UIFont.systemFont(ofSize: 43.0, weight: UIFont.Weight(rawValue: -0.8))
        }
        else {
            view.font = UIFont.systemFont(ofSize: 43.0)
        }
        return view
    }()

    init() {
        super.init(frame: CGRect.zero)
        layer.contents = UIImage(named: "wallet_header_bg")?.cgImage
        
        addSubview(titleLabel)
    
        addSubview(amountLabel)
       
        addSubview(amountIconImageView)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX).offset(20)
        }
        
        amountIconImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(amountLabel.snp.left).offset(-5)
            make.centerY.equalTo(amountLabel.snp.centerY)
            make.height.equalTo(amountLabel.snp.height)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
