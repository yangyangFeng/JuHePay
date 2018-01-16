//
//  APCommonProblemsViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCommonProblemsViewController: APBaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "常见问题"
        ap_setStatusBarStyle(.lightContent)
    }

    override func ap_url() -> String {
        return APHttpService.commonQuestion
    }
    
}
