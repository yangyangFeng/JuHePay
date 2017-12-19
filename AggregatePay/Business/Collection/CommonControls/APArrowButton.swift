//
//  APArrowButton.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APArrowButton : UIView {
    
    var margin : CGFloat = 12
    
    let rightArrow : UIImageView = {
        let view = UIImageView(image: UIImage.init(named: "Mine_head_arrow"))
        return view
    }()
    
    var title : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.init(hex6: 0x4c370b)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    let button : UIButton = {
        let view = UIButton(type: UIButtonType.custom)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rightArrow)
        addSubview(title)
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightArrow.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(snp.centerY).offset(0)
            make.right.equalTo(0)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(snp.centerY).offset(0)
            make.right.equalTo(rightArrow.snp.left).offset(-margin)
        }
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

