//
//  APHomeViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeViewController: APBaseViewController {
    
    var menuView: UIView = UIView()
    var keyboardCompositionView: APKeyboardCompositionView = APKeyboardCompositionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收款"
        self.edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        menuView.backgroundColor = UIColor.red
        
        view.addSubview(menuView)
        view.addSubview(keyboardCompositionView)
        
        menuView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
        keyboardCompositionView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(menuView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    

  

}
