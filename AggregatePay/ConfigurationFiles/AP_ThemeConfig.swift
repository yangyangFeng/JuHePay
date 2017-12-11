//
//  AP_ThemeConfig.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import Foundation
import SwiftTheme

private let defaults = UserDefaults.standard
private let lastThemeIndexKey = "AP_LastThemeIndex"

/// 全局颜色配置
enum APGlobalPicker {
    static let navgationBarBackGroundColors = ["#000", "#FFF", "#FFF", "#FFF"]
    
    static let backgroundColor: ThemeColorPicker = ["#fff", "#fff", "#fff", "#292b38"]
    static let textColor: ThemeColorPicker = ["#000", "#000", "#000", "#ECF0F1"]
    
    static let barTextColors = ["#000", "#FFF", "#FFF", "#FFF"]
    static let barTextColor = ThemeColorPicker.pickerWithColors(barTextColors)
    static let barTintColor: ThemeColorPicker = ["#EB4F38", "#F4C600", "#56ABE4", "#01040D"]
}


/// 主题管理
enum APP_Theme : Int{
    case Normal     =   0
    case Test       =   1
    
    // MARK: -
    
    static var current: APP_Theme { return APP_Theme(rawValue: ThemeManager.currentThemeIndex)! }
    static var before = APP_Theme.Normal
    
    static func switchThemeTo(theme : APP_Theme)
    {
        before = current
        ThemeManager.setTheme(index: theme.rawValue)
    }
    
    static func restoreLastTheme()
    {
        switchThemeTo(theme: APP_Theme(rawValue: defaults.integer(forKey: lastThemeIndexKey))!)
    }
}






class AP_ThemeConfig: NSObject {

}
