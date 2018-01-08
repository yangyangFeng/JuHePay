//
//  APRegisterProtocolViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/8.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterProtocolViewController: APBaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册协议"
        view.backgroundColor = UIColor.white
        vhl_setNavBackgroundColor(UIColor.white)
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
    }
    
    override func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "Navigation_Back")
        return image!.withRenderingMode(.alwaysOriginal)
    }
    
    override func ap_url() -> String {
        return APHttpService.agreement
    }
}

