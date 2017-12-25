//
//  APWalletHeaderView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APWalletHeaderView: UIView {
    
    //MARK: ---- life cycle
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.clear
        
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(amountIconImageView)
        
        contentView.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        amountLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.centerY).offset(-10)
            make.centerX.equalTo(contentView.snp.centerX).offset(20)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(amountLabel.snp.top).offset(-5)
            make.centerX.equalTo(contentView.snp.centerX)
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
    
    //MARK: ---- lazy loading
    lazy var contentView:UIView = {
        let view = UIView()
        let image = UIImage.init(named: "Earning_head_bg")
        let newImage = image?.cropped(to: CGRect.init(x: 0, y: (image?.size.height)!*(64/204), width: (image?.size.width)!, height: (image?.size.height)!*(1-64/204)))
        view.layer.contents = newImage?.cgImage
        return view
    }()
    
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
        view.text = "88880.0"
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
    
}
