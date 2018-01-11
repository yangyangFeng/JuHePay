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
    }

    override func queryDidAction() {
        //继承父类自动查询方法
        //本次需求从账单这边首次进入默认不查询信息
    }
    
    public func queryButAction() {
        loadData()
    }

}
