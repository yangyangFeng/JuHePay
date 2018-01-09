//
//  APQRCodeCollectionView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 生成收款二维码视图页面
 */
class APQRCodeCollectionView: UIView {
    
    lazy var navBarView: UIView = {
        let view = UIView()
        view.layer.contents = UIImage(named: "collection_qrcode_navbar_bg")?.cgImage
        return view
    }()
    
    lazy var navBarTitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "微信扫码收款"
        view.theme_textColor = ["#7f5e12"]
        view.font = UIFont.systemFont(ofSize: 18.0)
        return view
    }()
    
    lazy var merchantTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "商家:xxxxxxxxxx向您发起收款"
        view.textAlignment = .center
        view.theme_textColor = ["#c8a556"]
        view.font = UIFont.systemFont(ofSize: 14.0)
        return view
    }()
    
    lazy var qrCodeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var dateLimitLabel: UILabel = {
        let view = UILabel()
        view.text = "有效期10分钟"
        view.textAlignment = .center
        view.theme_textColor = ["#9c9b99"]
        view.font = UIFont.systemFont(ofSize: 12.0)
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        addSubview(navBarView)
        addSubview(navBarTitleLabel)
        addSubview(merchantTitleLabel)
        addSubview(qrCodeImageView)
        addSubview(dateLimitLabel)
        
        navBarView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(self.snp.top)
            maker.height.equalTo(60)
        }
        navBarTitleLabel.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalTo(navBarView)
        }
        
      
        qrCodeImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.snp.centerX)
            maker.centerY.equalTo(self.snp.centerY).offset(30)
            maker.width.equalTo(self.snp.width).multipliedBy(0.8)
            maker.height.equalTo(self.snp.width).multipliedBy(0.8)
        }
        
        merchantTitleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(navBarView.snp.bottom)
            maker.bottom.equalTo(qrCodeImageView.snp.top)
        }
        
        dateLimitLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(qrCodeImageView.snp.bottom)
            maker.bottom.equalTo(self.snp.bottom)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
