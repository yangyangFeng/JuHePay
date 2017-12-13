//
//  APKeyboardCompositionView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
/**
 * 用于组合键盘和显示框的视图
 * 1、组合键盘视图和显示框视图的布局
 * 2、控制键盘和显示框之间的传递关系（MVC-C）
 */
class APKeyboardCompositionView: UIView, APKeyboardViewDelegate{
    
    //键盘区域
    var keyboardView: APKeyboardView?
    
    //显示区
    var displayView: APDisplayView?
    
    init() {
        super.init(frame: CGRect.zero)
        keyboardView = getKeyboardView()
        displayView = getDisplayView()
        keyboardView!.keyboardDelegate = self
        addSubview(keyboardView!)
        addSubview(displayView!)
        displayView?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(self.snp.height).multipliedBy(0.25)
        }
        keyboardView?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(displayView!.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     * 返回键盘视图（允许继承APKeyboardView后自定义样式）
     */
    public func getKeyboardView() -> APKeyboardView {
        return APKeyboardView()
    }
    
    /**
     * 返回显示视图（允许继承APDisplayView后自定义样式）
     */
    public func getDisplayView() -> APDisplayView {
        return APDisplayView()
    }
    
    /**
     * 设置当前选中的支付方式的图标
     */
    public func setDisplayWayTypeImage(string: String) {
        displayView!.displayWayIcon.theme_image = [string]
    }
    
    //MARK: APKeyboardViewDelegate(键盘代理方法)
    
    func didKeyboardNumItem(num: String) {
        _ = displayView!.inputDisplayNumValue(num: num)
    }

    func didKeyboardDeleteItem() {
       _ = displayView!.deleteDisplayNumValue()
    }
    
    func didKeyboardConfirmItem() {
        print("confirm: \(displayView!.outputDisplayNumValue())")
    }
    

}













