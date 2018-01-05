//
//  APCollectionCompositionView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionCompositionView: APKeyboardCompositionView {
    
    public var isLogin = false {
        willSet {
            let collectionkeyboardView: APCollectionKeyboardView = keyboardView as! APCollectionKeyboardView
            if newValue {
                 collectionkeyboardView.loginYesConfirmButtonAttribute()
            }
            else {
                collectionkeyboardView.loginNoConfirmButtonAttribute()
            }
        }
    }
    
    public var menuModel: APHomeMenuModel? {
        willSet {
            displayView?.setDisplayExtParam(param: newValue as Any)
        }
    }
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    //MARK: ---- 重载父类方法
    
    override func ap_remove() {
        displayView?.ap_remove()
    }
    
    override func getKeyboardView() -> APKeyboardView {
        return APCollectionKeyboardView()
    }

    override func getDisplayView() -> APDisplayView {
        return APCollectionDisplayView()
    }

    override func confirmParam() -> Any {
        return menuModel as Any
    }
}


