//
//  APSelectBoxFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSelectBoxFormsCell: APBaseFormsCell {

    var button: UIButton = UIButton()
    
    override init() {
        super.init()
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.theme_setTitleColor(["#d09326"], forState: .normal)
        button.theme_setTitleColor(["#d09326"], forState: .selected)
        button.theme_setImage(["sys_memory_nor_icon"], forState: .normal)
        button.theme_setImage(["sys_memory_sel_icon"], forState: .selected)
        button.addTarget(self,
                         action: #selector(clickButton(_:)),
                         for: UIControlEvents.touchUpInside)
        self.addSubview(button)
        
        button.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(self.snp.height).multipliedBy(0.75)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickButton(_ button: UIButton) {
        buttonBlock?(identify, button)
    }
}
