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
    
    //规则模板
    let inputRulesTemplate: APKeyboardInputRulesTemplate = APKeyboardInputRulesTemplate()
    
    //图标
    lazy var displayWayIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    //提示
    lazy var displayPrompt: UILabel = {
        let view = UILabel()
        view.text = "请输入收款金额"
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#4c370b"]
        return view
    }()
    
    //金额图标
    lazy var displayAmountIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.contentMode = .scaleAspectFit
        view.theme_image = ["keyboard_money_icon"]
        return view
    }()
    
    //显示数字
    lazy var displayNum: UITextField = {
        let view = UITextField()
        view.placeholder = "0.0"
        view.minimumFontSize = 14
        view.textAlignment = .left
        view.textColor = UIColor.init(rgba: "#45340F")
        view.isUserInteractionEnabled = false
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 36)
        view.setValue(UIFont.systemFont(ofSize: 36),
                      forKeyPath: "_placeholderLabel.font")
        view.setValue(UIColor.init(rgba: "#45340F"),
                      forKeyPath: "_placeholderLabel.textColor")
        return view
        
    }()
    
    
    init() {
        super.init(frame: CGRect.zero)
    
        self.layer.contents = UIImage(named: "keyboard_display_bg")?.cgImage
        
        addSubview(displayWayIcon)
        addSubview(displayPrompt)
        addSubview(displayAmountIcon)
        addSubview(displayNum)
        
        displayWayIcon.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.25)
            make.width.equalTo(self.snp.height).multipliedBy(0.25)
        }
        
        displayPrompt.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(displayWayIcon.snp.right).offset(10)
            make.centerY.equalTo(displayWayIcon.snp.centerY)
            make.height.equalTo(displayWayIcon.snp.height)
        }
        
        displayAmountIcon.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(displayWayIcon.snp.left)
            make.top.equalTo(displayWayIcon.snp.bottom).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.width.equalTo(self.snp.height).multipliedBy(0.25)
        }
        
        displayNum.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(displayAmountIcon.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(displayAmountIcon.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 输入
     */
    public func inputDisplayNumValue (num: String) {
        displayNum.text = inputRulesTemplate.inputRules(display: displayNum.text!, num: num)
    }
    
    /**
     * 删除
     */
    public func outputDisplayNumValue() -> String {
        return displayNum.text!
    }
    
    /**
     * 输出
     */
    public func deleteDisplayNumValue() {
        displayNum.text = inputRulesTemplate.deleteRules(display: displayNum.text!)
    }
    
    
}














