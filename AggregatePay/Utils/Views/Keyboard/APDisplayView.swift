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
    var displayWayIcon: UIImageView = UIImageView()
    
    //提示
    var displayPrompt: UILabel = UILabel()
    
    //金额图标
    var displayAmountIcon: UIImageView = UIImageView()
    
    //显示数字
    var displayNum: UITextField = UITextField()
    
    //是否有小数点：默认false
    var isPointNum: Bool = false
    
 
    init() {
        super.init(frame: CGRect.zero)
    
        self.layer.contents = UIImage(named: "keyboard_display_bg")?.cgImage
        
        setDisplayWayIconAttribute()
        setDisplayPromptAttribute()
        setDisplayAmountIconAttribute()
        setDisplayNumAttribute()
        
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
    
    private func setDisplayWayIconAttribute() {
        displayWayIcon.backgroundColor = UIColor.clear
        displayWayIcon.contentMode = .scaleAspectFit
    }
    
    private func setDisplayAmountIconAttribute() {
        displayAmountIcon.backgroundColor = UIColor.clear
        displayAmountIcon.contentMode = .scaleAspectFit
        displayAmountIcon.theme_image = ["keyboard_money_icon"]
    }
    
    private func setDisplayPromptAttribute() {
        displayPrompt.text = "请输入收款金额"
        displayPrompt.textAlignment = .left
        displayPrompt.font = UIFont.systemFont(ofSize: 12)
        displayPrompt.theme_textColor = ["#4c370b"]
    }
    
    private func setDisplayNumAttribute() {
        displayNum.placeholder = "0.0"
        displayNum.minimumFontSize = 14
        displayNum.textAlignment = .left
        displayNum.textColor = UIColor.init(rgba: "#45340F")
        displayNum.isUserInteractionEnabled = false
        displayNum.adjustsFontSizeToFitWidth = true
        displayNum.font = UIFont.systemFont(ofSize: 36)
        displayNum.setValue(UIFont.systemFont(ofSize: 36),
                            forKeyPath: "_placeholderLabel.font")
        displayNum.setValue(UIColor.init(rgba: "#45340F"),
                            forKeyPath: "_placeholderLabel.textColor")
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














