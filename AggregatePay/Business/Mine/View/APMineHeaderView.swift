//
//  APMineHeaderView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APMineHeaderView: UIView {

    private let textColor : UInt32 = 0x4c370b
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        //黑色背景
        let bgImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_bg")?.cropped(to: -(208-64)/208))
        //用户背景
        let userBgImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_user_bg"))
        //用户头像
        let userIconImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_user_icon"))
        
        //------------------------以下 view 未布局-----------------
        let userTitleLabel : UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hex6: textColor)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .left
            label.text = "张**"
            return label
        }()

        let user_level_icon_imageView = UIImageView.init(image: UIImage.init(named: "Mine_head_user_level_2"))
     
        let user_level_title_imageView = UIImageView.init(image: UIImage.init(named: "Mine_head_user_level_title_2"))
        
        let userTelLabel = UILabel()
        userTelLabel.font = UIFont.systemFont(ofSize: 10)
        userTelLabel.textColor = UIColor(hex6 : textColor)
        userTelLabel.textAlignment = .left
        userTelLabel.text = "手机号: "
      
        
        let recommendLabel = UILabel()
        recommendLabel.font = UIFont.systemFont(ofSize: 10)
        recommendLabel.textColor = UIColor(hex6 : textColor)
        recommendLabel.textAlignment = .left
        recommendLabel.text = "推荐人: "
      
        
        let arrowImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_arrow"))
       
        let checkStatusLabel = UILabel()
        checkStatusLabel.font = UIFont.systemFont(ofSize: 12)
        checkStatusLabel.textColor = UIColor(hex6: textColor)
        checkStatusLabel.textAlignment = .right
        checkStatusLabel.text = "已认证"
        
        addSubview(bgImageView)
        bgImageView.addSubview(userBgImageView)
        userBgImageView.addSubview(userIconImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        userBgImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(12)
        }
        userIconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(userBgImageView.snp.top).offset(21)
            make.left.equalTo(userBgImageView.snp.left).offset(22)
            make.height.width.equalTo(60)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(userTitleLabel)
        userTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(31)
            make.left.equalTo(userIconImageView.snp.right).offset(13)
            make.height.equalTo(18)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(user_level_title_imageView)
        user_level_title_imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(22)
            make.top.equalTo(59)
            make.left.equalTo(64)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(user_level_icon_imageView)
        user_level_icon_imageView.snp.makeConstraints { (make) in
            make.width.equalTo(64)
            make.height.equalTo(17)
            make.centerY.equalTo(userTitleLabel.snp.centerY).offset(0)
            make.left.equalTo(userTitleLabel.snp.right).offset(6)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(recommendLabel)
        recommendLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userTitleLabel.snp.left).offset(0)
            make.bottom.equalTo(-14)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(userTelLabel)
        userTelLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userTitleLabel.snp.bottom).offset(8)
            make.left.equalTo(userTitleLabel.snp.left).offset(0)
            make.height.equalTo(12)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(userBgImageView.snp.centerY).offset(0)
            make.right.equalTo(userBgImageView.snp.right).offset(-20)
        }
        //---------------------------------------------------
        userBgImageView.addSubview(checkStatusLabel)
        checkStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrowImageView.snp.centerY).offset(0)
            make.right.equalTo(arrowImageView.snp.left).offset(-4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
