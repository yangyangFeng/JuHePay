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
        vhl_setNavBackgroundColor(UIColor.white)
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
    }
    
    override func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "Navigation_Back")
        return image!.withRenderingMode(.alwaysOriginal)
    }
}
