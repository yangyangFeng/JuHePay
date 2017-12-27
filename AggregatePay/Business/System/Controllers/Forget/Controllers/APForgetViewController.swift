//
//  APForgetViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APForgetViewController: APSystemBaseViewController {

    
    var prompt: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"

        prompt.theme_textColor = ["#d09326"]
        prompt.theme_backgroundColor = ["#fff4d9"]
        prompt.font = UIFont.systemFont(ofSize: 10)
        prompt.text = "    为了保障您的账户安全，请输入注册手机号码进行验证。"
        view.addSubview(prompt)
        prompt.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(25)
        }
    }
}
