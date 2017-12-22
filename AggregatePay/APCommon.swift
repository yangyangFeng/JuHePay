//
//  CPCommon.swift
//  framework
//
//  Created by BlackAnt on 2017/12/4.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit

class APCommon: NSObject {

    //请求地址
    static var http_url = "http://192.168.1.240:29111"
    
    enum APPort: String {
        case login = "/login.action"
    }
}

let AP_TableViewBackgroundColor = "#F5F5F5"

/// 获取AppDelegate
let APPDElEGATE = UIApplication.shared.delegate as! AppDelegate

/// 获取屏幕宽和高
let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height
