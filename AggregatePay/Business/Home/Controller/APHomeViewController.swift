//
//  APHomeViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeViewController: APBaseViewController {
    
    var keyboardCompositionView: APKeyboardCompositionView = APKeyboardCompositionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收款"
        view.addSubview(keyboardCompositionView)
        keyboardCompositionView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top).offset(200)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    

  

}
