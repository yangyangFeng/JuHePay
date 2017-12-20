//
//  APSystemBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import KVOController

class APSystemBaseViewController: APBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        vhl_setNavBarBackgroundImage(UIImage.init(named: "home_nav_bg"))
    }

    override func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "sys_nav_back_icon")
        return image!.withRenderingMode(.alwaysOriginal)
    }
}
