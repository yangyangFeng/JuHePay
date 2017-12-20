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
        view.placeholder = "0.00"
        view.minimumFontSize = 14
        view.textAlignment = .left
        view.textColor = UIColor.init(rgba: "#45340F")
        view.isUserInteractionEnabled = false
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 36)
        view.setValue(UIFont.systemFont(ofSize: 36),
                      forKeyPath: "_placeholderLabel.font")
        view.setValue(UIColor.init(rgba: "#C7BEAA"),
                      forKeyPath: "_placeholderLabel.textColor")
        return view
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        addSubview(displayWayIcon)
        addSubview(displayPrompt)
        addSubview(displayAmountIcon)
        addSubview(displayNum)
        
        displayWayIcon.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
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
    
    //MARK: ---- 重写父类方法
    
    override  func inputDisplayNumValue (num: String) {
        displayNum.text = num
    }

    override  func deleteDisplayNumValue(num: String) {
        displayNum.text = num
    }

    override func outputDisplayNumValue() -> String {
        return displayNum.text!
    }
    
    override func setDisplayExtParam(param: Any) {
        let homeMenuModel: APHomeMenuModel = param as! APHomeMenuModel
        displayWayIcon.theme_image = [homeMenuModel.wayIconImage]
    }
    
}












