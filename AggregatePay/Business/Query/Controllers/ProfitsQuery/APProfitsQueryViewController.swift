//
//  APProfitsQueryViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APProfitsQueryViewController: APReturnBillViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let leftButton = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.done, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftButton
    }

}
