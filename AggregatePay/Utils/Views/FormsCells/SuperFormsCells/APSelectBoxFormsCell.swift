//
//  APSelectBoxFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSelectBoxFormsCell: APBaseFormsCell {

    var button: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .selected)
        view.theme_setImage(["sys_memory_nor_icon"], forState: .normal)
        view.theme_setImage(["sys_memory_sel_icon"], forState: .selected)
        view.addTarget(self, action: #selector(clickButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    override init() {
        super.init()
        
        bottomLine.backgroundColor = UIColor.clear
        
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
    
    @objc func clickButton(_ buttonParam: UIButton) {
        button.isSelected = !buttonParam.isSelected
        buttonBlock?(identify, button)
    }
}
