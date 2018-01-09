//
//  APDefaultKeyboardView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionKeyboardView: APKeyboardView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
    }
    
    func isLogin(_ isLogin: Bool) {
        if isLogin {
            loginConfirmButtonAttribute(button: confirmButton!)
        }
        else {
            notLoginConfirmButtonAttribute(button: confirmButton!)
        }
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
    
    override func notLoginConfirmButtonAttribute(button: APKeyboardButton) {
        button.backgroundImage.theme_image = ["keyboard_confirm_notReg_bg"]
        button.backgroundNorImage = "keyboard_confirm_notReg_bg"
        button.backgroundSelImage = "keyboard_confirm_notReg_sel_bg"
    }
    
    override func loginConfirmButtonAttribute(button: APKeyboardButton) {
        button.backgroundImage.theme_image = ["keyboard_confirm_bg"]
        button.backgroundNorImage = "keyboard_confirm_bg"
        button.backgroundSelImage = "keyboard_confirm_sel_bg"
    }
    
}
