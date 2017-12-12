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
    
    let inputRulesTemplate: APKeyboardInputRulesTemplate = APKeyboardInputRulesTemplate()

    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 输入
     */
    public func inputDisplayNumValue (num: String) {
        print("子类重写")
    }
    
    /**
     * 删除
     */
    public func deleteDisplayNumValue() {
        print("子类重写")
    }
    
    /**
     * 输出
     */
    public func outputDisplayNumValue() -> String {
        print("子类重写")
        return ""
    }
    
    
}














