//
//  APBaseKeyboardView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 键盘视图
 * 1、创建键盘按钮并进行布局
 * 2、用户操作视图产生数据后传递给键盘组合视图（MVC-M）
 */

protocol APKeyboardViewDelegate : NSObjectProtocol {
    func didKeyboardNumItem(num: String)
    func didKeyboardDeleteItem()
    func didKeyboardConfirmItem()
    
}

let APDecimalPoint: String = "."

class APKeyboardView: UIView {
    
    var backgroundView: UIView = UIView()
    var keyboardDelegate: APKeyboardViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        self.layer.contents = UIImage(named: "keyboard_bg")?.cgImage
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
        //定义键盘键名称（？号是占位符, !表示确定, -表示删除）
        let keys = ["1" ,"2" ,"3" ,"-",
                    "4" ,"5" ,"6" ,"!" ,
                    "7" ,"8" ,"9" ,"?" ,
                    "00","0" ,APDecimalPoint ,"?" ]
        var buttonArray = [APKeyboardButtonView]()
        for i in 0..<4 {
            for j in 0..<4 {
                let indexOfKeys = i * 4 + j
                let key = keys[indexOfKeys]
                //键盘样式
                let button = buttonAttribute(title: key)
                button.transform = .init(scaleX: 0.95, y: 0.95)
                backgroundView.addSubview(button)
                buttonArray.append(button)
                if (key == "?") {
                    button.removeFromSuperview()
                    continue
                }
                button.snp.makeConstraints({ (make) in
                    //添加宽度约束
                    make.width.equalTo(backgroundView.snp.width).multipliedBy(0.25)
                    //添加高度约束
                    if (key == "!") {
                        make.height.equalTo(backgroundView.snp.height).multipliedBy(0.75)
                    }
                    else {
                        make.height.equalTo(backgroundView.snp.height).multipliedBy(0.25)
                    }
                    
                    //添加垂直位置约束
                    if i == 0 {
                        make.top.equalTo(0)
                    }
                    else{
                        make.top.equalTo(buttonArray[indexOfKeys-4].snp.bottom)
                    }
                    //添加水平位置约束
                    switch (j) {
                    case 0:
                        make.left.equalTo(backgroundView.snp.left)
                    case 1:
                        make.right.equalTo(backgroundView.snp.centerX)
                    case 2:
                        make.left.equalTo(backgroundView.snp.centerX)
                    case 3:
                        make.right.equalTo(backgroundView.snp.right)
                    default:
                        break
                    }
                })
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func buttonAttribute(title: String) ->APKeyboardButtonView {
        //？号是占位符, !表示确定, -表示删除
        let button = APKeyboardButtonView()
        if (title == "!") {
            //设置圆角边框
            button.titleText = ""
            button.backgroundImage.theme_image = ["keyboard_confirm_bg"]
            button.addTarget(self, action: #selector(didKeyboardConfirmItem))
        }
        else if (title == "-") {
            button.titleText = ""
            button.backgroundImage.theme_image = ["keyboard_delete_bg"]
            button.addTarget(self, action: #selector(didKeyboardDeleteItem))
        }
        else {
            button.titleText = title
            button.backgroundImage.theme_image = ["keyboard_num_bg"]
            button.addTarget(self, action: #selector(didKeyboardNumItem(_:)))
        }
        return button
    }
    
    //MARK: ----- action
    
    @objc func didKeyboardNumItem(_ button: UIButton) {
        let numStr: String = (button.title(for: .normal))!
        keyboardDelegate?.didKeyboardNumItem(num: numStr)
    }
    
    @objc func didKeyboardDeleteItem() {
        keyboardDelegate?.didKeyboardDeleteItem()
    }
    
    @objc func didKeyboardConfirmItem() {
        keyboardDelegate?.didKeyboardConfirmItem()
    }
    
}









