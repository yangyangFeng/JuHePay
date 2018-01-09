//
//  APMineHeaderView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APMineHeaderView: UIView {

    static func securityFiltering(_ str:String?, pre : Int, suf : Int) -> String {
        var i = 0
        var newStr : String = ""
        guard let tempStr : String = str else {
            return ""
        }
        for a in tempStr
        {
            if i < pre{
                newStr.append(a)
            }
            else if i >= tempStr.count - suf{
                newStr.append(a)
            }
            else
            {
                newStr.append("*")
            }
            i+=1
        }
        return newStr
    }
    
    var model : APUserInfoResponse?{
        didSet{
            arrowImageView.isHidden = false
            userTitleLabel.text = APMineHeaderView.securityFiltering((model?.realName), pre: 1, suf: 0)
   
            userTelLabel.text = "手机号: " + APMineHeaderView.securityFiltering((model?.mobileNo), pre: 3, suf: 4)
            let recommendInfo = (model?.recommendUserMobileNo ?? "")! + " " + (model?.recommendUserName ?? "")!
            
            if recommendInfo.count > 1{
                recommendLabel.text = "推荐人: " + recommendInfo
            }
            else
            {
                recommendLabel.text = ""
            }
            if model?.isRealName == "1" {
                checkStatusLabel.text = "已认证"
            }
            else
            {
                checkStatusLabel.text = "未认证"
            }
            if model?.levelId == nil
            {
                user_level_icon_imageView.image =  UIImage()
                user_level_title_imageView.image = UIImage()
                levelName.text = ""
            }
            else {
                user_level_icon_imageView.image =  UIImage.init(named: "Mine_head_user_level_" + (model?.levelId)!)
                user_level_title_imageView.image = UIImage.init(named: "Mine_head_user_level_title_" + (model?.levelId)!)
                levelName.text = model?.levelName ?? ""
            }
            
        }
    }
    
    //用户头像
    let userIconImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_user_icon"))
    
    //------------------------以下 view 未布局-----------------
    let userTitleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex6: 0x4c370b)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "请点击登录"
        return label
    }()
    
    let checkStatusLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor(hex6: 0x4c370b)
        view.textAlignment = .right
        view.text = ""
        return view
    }()
    
    
    let userTelLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = UIColor(hex6 : 0x4c370b)
        view.textAlignment = .left
        view.text = "--"
        return view
    }()
    
    
    let recommendLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = UIColor(hex6 : 0x4c370b)
        view.textAlignment = .left
        view.text = ""
        return view
    }()
    
    let levelName : UILabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = UIColor.init(hex6: 0xffffff)
        view.textAlignment = .center
        return view
    }()
    
    
    //黑色背景
    let bgImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_bg")?.cropped(to: -(208-64)/208))
    //用户背景
    let userBgImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_user_bg"))
    
    
    var user_level_title_imageView = UIImageView()
//    init(image: UIImage.init(named: "Mine_head_user_level_title_2"))
    
    let user_level_icon_imageView = UIImageView()
//        .init(image: UIImage.init(named: "Mine_head_user_level_2"))
    
    
    let arrowImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_arrow"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        arrowImageView.isHidden = true
        addSubview(bgImageView)
        bgImageView.addSubview(userBgImageView)
        userBgImageView.addSubview(userIconImageView)
        
        //---------------------------------------------------
        userBgImageView.addSubview(userTitleLabel)
       
        //---------------------------------------------------
        userBgImageView.addSubview(user_level_title_imageView)
       
        //---------------------------------------------------
        userBgImageView.addSubview(user_level_icon_imageView)
      
        //---------------------------------------------------
        userBgImageView.addSubview(recommendLabel)
      
        //---------------------------------------------------
        userBgImageView.addSubview(userTelLabel)
      
        //---------------------------------------------------
        userBgImageView.addSubview(arrowImageView)
     
        //---------------------------------------------------
        userBgImageView.addSubview(checkStatusLabel)
        
        user_level_title_imageView.addSubview(levelName)
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        userBgImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(12)
        }
        userIconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(userBgImageView.snp.top).offset(21)
            make.left.equalTo(userBgImageView.snp.left).offset(22)
            make.height.width.equalTo(60)
        }
        userTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(31)
            make.left.equalTo(userIconImageView.snp.right).offset(13)
            make.height.equalTo(18)
        }
        user_level_icon_imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(22)
            make.top.equalTo(59)
            make.left.equalTo(64)
        }
        user_level_title_imageView.snp.makeConstraints { (make) in
            make.width.equalTo(64)
            make.height.equalTo(17)
            make.centerY.equalTo(userTitleLabel.snp.centerY).offset(0)
            make.left.equalTo(userTitleLabel.snp.right).offset(6)
        }
        recommendLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userTitleLabel.snp.left).offset(0)
            make.bottom.equalTo(-14)
        }
        userTelLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userTitleLabel.snp.bottom).offset(8)
            make.left.equalTo(userTitleLabel.snp.left).offset(0)
            make.height.equalTo(12)
        }
        arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(userBgImageView.snp.centerY).offset(0)
            make.right.equalTo(userBgImageView.snp.right).offset(-20)
            //            make.right.equalTo(-20)
        }
        checkStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(arrowImageView.snp.centerY).offset(0)
            make.right.equalTo(arrowImageView.snp.left).offset(-4)
        }
        levelName.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
