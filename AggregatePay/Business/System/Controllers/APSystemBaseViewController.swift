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

    let leftOffset: Float = 30
    let rightOffset: Float = -30
    let cellHeight: Float = 44
    let subimtHeight: Float = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
    }

    

}
