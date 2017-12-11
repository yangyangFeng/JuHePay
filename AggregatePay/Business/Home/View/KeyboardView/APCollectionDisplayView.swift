//
//  APDefaultDisplayView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionDisplayView: APDisplayView {
    
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

    override init() {
        super.init()
        
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
            make.width.equalTo(displayWayIcon.snp.width)
        }
        
        displayNum.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(displayAmountIcon.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(displayAmountIcon.snp.top)
            make.bottom.equalTo(displayAmountIcon.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDisplayWayIconAttribute() {
        displayWayIcon.backgroundColor = UIColor.white
    }
    
    private func setDisplayAmountIconAttribute() {
        displayAmountIcon.backgroundColor = UIColor.white
    }

    private func setDisplayPromptAttribute() {
        displayPrompt.text = "请输入收款金额"
        displayPrompt.textAlignment = .left
        displayPrompt.textColor = UIColor.white
    }
    
    private func setDisplayNumAttribute() {
        displayNum.placeholder = "0.0"
        displayNum.minimumFontSize=14
        displayNum.textAlignment = .left
        displayNum.textColor = UIColor.white
        displayNum.isUserInteractionEnabled = false
        displayNum.adjustsFontSizeToFitWidth = true
        displayNum.font = UIFont(name:"HeiTi SC", size:40)
        displayNum.setValue(UIFont.systemFont(ofSize: 40),
                            forKeyPath: "_placeholderLabel.font")
        displayNum.setValue(UIColor.white,
                            forKeyPath: "_placeholderLabel.textColor")
    }
    
    override func inputDisplayNumValue (num: String) {
        displayNum.text = inputRulesTemplate.inputRules(display: displayNum.text!, num: num)
    }
    
    override func outputDisplayNumValue() -> String {
        return displayNum.text!
    }
    
    override func deleteDisplayNumValue() {
        displayNum.text = inputRulesTemplate.deleteRules(display: displayNum.text!)
    }
    
}












