//
//  APQRCodeSelectMerchantCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码选择商户类型
 */
class APQRCodeSelectMerchantCell: APBaseFormsCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#999999"]
        view.textAlignment = .left
        view.text = "选择商户类型"
        return view
    }()
    
    lazy var arronImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.theme_image = ["wallet_arron_right_icon"]
        return view
    }()

    override init() {
        super.init()
        self.backgroundColor = UIColor.white
        bottomLine.backgroundColor = UIColor.clear
        addSubview(titleLabel)
        addSubview(arronImageView)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(20)
        }
        
        arronImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
