//
//  APSubmitFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSubmitFormsCell: APBaseFormsCell {
    
    var button: APRequestButton = {
        let view = APRequestButton()
        view.isEnabled = true
        view.layer.cornerRadius = 44/2
        view.layer.masksToBounds = true
        view.titleLabel?.textAlignment = .center
        view.theme_setBackgroundImage(["login_nor_button_bg"], forState: .normal)
        view.theme_setBackgroundImage(["login_nor_button_bg"], forState: .selected)
        view.theme_setBackgroundImage(["login_en_button_bg"], forState: .disabled)
        view.theme_setTitleColor(["#422f02"], forState: .normal)
        view.theme_setTitleColor(["#422f02"], forState: .selected)
        view.theme_setTitleColor(["#626262"], forState: .disabled)
        view.addTarget(self, action: #selector(clickButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()

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
        self.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickButton(_ button: UIButton) {
        buttonBlock?(identify, button)
    }

}
