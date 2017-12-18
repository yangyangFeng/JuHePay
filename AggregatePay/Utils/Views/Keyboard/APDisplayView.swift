//
//  APBaseDisplayView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 显示框视图
 * 1、创建显示框文本和图标并进行布局
 * 2、通过键盘组合视图展示键盘视图键入的数据（MVC-V）
 */
class APDisplayView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        self.layer.contents = UIImage(named: "keyboard_display_bg")?.cgImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ---- 接口扩展
    
    /** 设置扩展参数 */
    func setDisplayExtParam(param: Any) {}
    
    /** 输入 */
    func inputDisplayNumValue (num: String) {}
    
    /** 删除 */
    func deleteDisplayNumValue(num: String) {}
    
    /** 输出 */
    func outputDisplayNumValue() -> String {return "0.0"}
}














