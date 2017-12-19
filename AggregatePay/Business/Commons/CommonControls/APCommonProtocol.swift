//
//  APCommonProtocol.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

@objc protocol AP_TableViewDidSelectProtocol : AP_ActionProtocol{
    @objc optional func AP_TableViewDidSelect(_ indexPath : IndexPath)
    @objc optional func AP_TableViewDidSelect(_ indexPath : IndexPath , obj : Any)
}

@objc protocol AP_ActionProtocol : NSObjectProtocol{
    @objc optional func AP_Action_Click()
    @objc optional func AP_Action_Click(_ obj : Any)
}
