//
//  APKeyboardButtonView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APKeyboardButtonView: UIView {
    
    //背景(UIImageView--背景图片保持图片尺寸正比例)
    var backgroundImage: UIImageView = UIImageView()
    
    //标题(UILabel--不能有图标)
    var titleLabel: UILabel = UILabel()
    
    //触发事件(UIButton--覆盖最外层用于用户点击)
    var button: UIButton = UIButton()
    
    var titleText: String = "" {
        willSet {
            button.setTitle(newValue, for: .normal)
            titleLabel.text = newValue
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundImage.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.clear, for: .normal)
        titleLabel.font = UIFont(name:"Arial-BoldItalicMT", size:30)
        titleLabel.theme_textColor = ["#8a8067"]
        titleLabel.textAlignment = .center
        
   
        self.addSubview(backgroundImage)
        self.addSubview(titleLabel)
        self.addSubview(button)
        
        backgroundImage.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
        button.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addTarget(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }

}
