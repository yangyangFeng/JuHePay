//
//  CPCommon.swift
//  framework
//
//  Created by BlackAnt on 2017/12/4.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit

class APCommon: NSObject {


}

let AP_TableViewBackgroundColor = "#F5F5F5"

let AP_AES_Key = "q+21NWcZFQLG0WuM"

let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
/// 获取AppDelegate
let APPDElEGATE = UIApplication.shared.delegate as! AppDelegate

/// 获取屏幕宽和高
let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height
