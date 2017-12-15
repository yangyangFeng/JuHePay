//
//  APForgetViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 忘记密码
 */
class APForgetViewController: APSystemBaseViewController {
    
    var prompt: UILabel = UILabel()
    var forgetAccountCell: APForgetAccountCell = APForgetAccountCell()
    var forgetSmsCodeCell: APForgetSmsCodeCell = APForgetSmsCodeCell()
    var forgetSubmitCell: APForgetSubmitCell = APForgetSubmitCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        prompt.theme_textColor = ["#d09326"]
        prompt.theme_backgroundColor = ["#fff4d9"]
        prompt.font = UIFont.systemFont(ofSize: 10)
        prompt.text = "    为了保障您的账户安全，请输入注册手机号码进行验证。"
        
        forgetAccountCell.identify = "forgetAccountID"
        forgetSmsCodeCell.identify = "forgetSmsCodeID"
        forgetSubmitCell.identify = "forgetSubmitID"
        
        view.addSubview(prompt)
        view.addSubview(forgetAccountCell)
        view.addSubview(forgetSmsCodeCell)
        view.addSubview(forgetSubmitCell)
        
        prompt.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(25)
        }
        
        forgetAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetSmsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetAccountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        forgetSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(forgetSmsCodeCell.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
        
        forgetAccountCell.textBlock = { (key, value) in
            print("forgetAccountCell:\(key) ___ value:\(value)")
        }
        
        forgetSmsCodeCell.textBlock = { (key, value) in
            print("forgetSmsCodeCell:\(key) ___ value:\(value)")
        }
        
        forgetSubmitCell.buttonBlock = { (key, value) in
            print("forgetSubmitCell:\(key) ___ value:\(value)")
            let modifyVC: APModifyViewController = APModifyViewController()
            self.navigationController?.pushViewController(modifyVC, animated: true)
        }
    }
   

}








