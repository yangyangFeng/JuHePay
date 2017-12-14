//
//  APSubmitFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSubmitFormsCell: APBaseFormsCell {
    
    var button: APRequestButton = APRequestButton()

    var isLoading: Bool = false {
        willSet {
            button.isLoading = newValue
        }
    }
    
    var isEnabled: Bool = false {
        willSet {
            button.isEnabled = newValue
        }
    }

    
    override init() {
        super.init()
        
        button.isEnabled = true
        button.layer.cornerRadius = 44/2
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
        button.theme_setBackgroundImage(["login_nor_button_bg"], forState: .normal)
        button.theme_setBackgroundImage(["login_nor_button_bg"], forState: .selected)
        button.theme_setBackgroundImage(["login_en_button_bg"], forState: .disabled)
        button.theme_setTitleColor(["#422f02"], forState: .normal)
        button.theme_setTitleColor(["#422f02"], forState: .selected)
        button.theme_setTitleColor(["#626262"], forState: .disabled)
        button.addTarget(self,
                         action: #selector(clickButton(_:)),
                         for: UIControlEvents.touchUpInside)
        self.addSubview(button)
        
        button.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalTo(self)
        }
        
        isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickButton(_ button: UIButton) {
        buttonBlock?(identify, button)
    }

}
