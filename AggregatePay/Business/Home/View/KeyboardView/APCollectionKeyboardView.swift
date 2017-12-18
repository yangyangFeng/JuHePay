//
//  APDefaultKeyboardView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionKeyboardView: APKeyboardView {
    
    /** 强引用确认按钮 */
    private var confirmButton: APKeyboardButton?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
    }
    
    override func numButtonAttribute(button: APKeyboardButton) {
        button.backgroundImage.theme_image = ["keyboard_num_bg"]
        button.backgroundNorImage = "keyboard_num_bg"
        button.backgroundSelImage = "keyboard_num_sel_bg"
    }
    
    override func deleteButtonAttribute(button: APKeyboardButton) {
        button.backgroundImage.theme_image = ["keyboard_delete_bg"]
        button.backgroundNorImage = "keyboard_delete_bg"
        button.backgroundSelImage = "keyboard_delete_sel_bg"
    }
    
    override func confirmButtonAttribute(button: APKeyboardButton) {
        confirmButton = button
        loginNoConfirmButtonAttribute()
    }
    
    //收款页面的键盘确认按钮需要验证是否登录（登录和未登录是两个图片，此处提供接口供组件类调用）
    func loginNoConfirmButtonAttribute() {
        confirmButton?.backgroundImage.theme_image = ["keyboard_confirm_notReg_bg"]
        confirmButton?.backgroundNorImage = "keyboard_confirm_notReg_bg"
        confirmButton?.backgroundSelImage = "keyboard_confirm_notReg_sel_bg"
    }
    
    func loginYesConfirmButtonAttribute() {
        confirmButton?.backgroundImage.theme_image = ["keyboard_confirm_bg"]
        confirmButton?.backgroundNorImage = "keyboard_confirm_bg"
        confirmButton?.backgroundSelImage = "keyboard_confirm_sel_bg"
    }
    
}
