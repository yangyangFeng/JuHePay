//
//  APBaseTabBarViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

import ESTabBarController_swift

class APBaseTabBarViewController: ESTabBarController {
    override func viewDidLoad() {
    super.viewDidLoad()
        let TopLine = UIView()
        TopLine.backgroundColor = UIColor(hex6: 0x323232)
        tabBar.addSubview(TopLine)
        
        TopLine.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
}
