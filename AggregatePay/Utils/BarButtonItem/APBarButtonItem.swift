//
//  APBarButtonItem.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBarButtonItem: NSObject {
    
    static func ap_barButtonItem(_ target: Any?, title: String, action: Selector) -> UIBarButtonItem{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        button.theme_setTitleColor(["#7F5E12"], forState: .normal)
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        let item = UIBarButtonItem(customView: button)
        return item
    }
    
}
