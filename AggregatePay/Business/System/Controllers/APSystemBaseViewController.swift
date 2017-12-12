//
//  APSystemBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSystemBaseViewController: APBaseViewController {

    let leftOffset: Float = 40
    let rightOffset: Float = -40
    let topOffset: Float = 100
    let cellHeight: Float = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
    }

    

}
