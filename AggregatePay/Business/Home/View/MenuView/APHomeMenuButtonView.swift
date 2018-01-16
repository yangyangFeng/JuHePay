//
//  APHomeMenuItemView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeMenuButtonView: UIView {

    
    let iconImageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let button: UIButton = UIButton()
    
    var model: APHomeMenuModel?
   
    init(itemModel: APHomeMenuModel) {
        super.init(frame: CGRect.zero)
        
        model = itemModel
        
        iconImageView.theme_image = [itemModel.norImage]
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont(name:"Arial-BoldItalicMT", size:12)
        if itemModel.wayIconImage == "" {
            titleLabel.theme_textColor = ["#D9CDB2"]
        }
        else {
            titleLabel.theme_textColor = ["#8a8067"]
        }
        titleLabel.textAlignment = .center
        titleLabel.text = itemModel.title
        
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.clear, for: .normal)
        
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(button)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(titleLabel.snp.top)
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

    public func showHighlighted() {
        iconImageView.theme_image = [(model?.selImage)!]
    }
    public func dissHighlighted() {
        iconImageView.theme_image = [(model?.norImage)!]
    }

}
