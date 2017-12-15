//
//  APPromoteViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 推广
 */
class APPromoteViewController: APBaseViewController {

    
    var button: APRequestButton = APRequestButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vhl_setNavBackgroundColor(UIColor.init(hex6: 0x373737))
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
    }

   

}
