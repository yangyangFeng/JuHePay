//
//  APVersionUpgradeManager.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APVersionUpgradeManager: NSObject {

    
    static func show(version: String, text: String) {
        APVersionUpgradeController().show(version: version, text: text)
    }
    
}
