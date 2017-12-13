//
//  APSubmitFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSubmitFormsCell: APBaseFormsCell {

    var button: UIButton = UIButton()
    
    override init() {
        super.init()
        
        button.isEnabled = true
        button.titleLabel?.textAlignment = .center
        button.addTarget(self,
                         action: #selector(clickButton(_:)),
                         for: UIControlEvents.touchUpInside)
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
