//
//  APRegisterViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 注册
 *一: 1、手机号：必须为11位，第一位必须为1（此处需要做正则校验）
      2、若输入错误toast提示：手机号输入格式不正确
 *二: 1、短信验证码：四位数字
      2、验证码错误提示：验证码输入不正确
 *三: 1、密码：由6-16位字母、数字或下划线组成。密码输入不能超过16位。
 *    2、若密码设置有误提示：密码格式不正确
 *四: 邀请码：输入错误提示：邀请码不正确
 *五: 必须全部填写完且勾选了用户协议，注册按钮才会亮起，否则置灰不可点击。
 */
class APRegisterViewController: APSystemBaseViewController {
    
    var registerAccountCell: APRegisterAccountCell = APRegisterAccountCell()
    var registerSmsCodeCell: APRegisterSmsCodeCell = APRegisterSmsCodeCell()
    var registerPasswordCell: APRegisterPasswordCell = APRegisterPasswordCell()
    var registerInviteCodeCell: APRegisterInviteCell = APRegisterInviteCell()
    var registerAgreedCell: APRegisterAgreedCell = APRegisterAgreedCell()
    var registerSubmitCell: APRegisterSubmitCell = APRegisterSubmitCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商户注册"
        
        registerAccountCell.identify = "registerAccountID"
        registerSmsCodeCell.identify = "registerSmsCodeID"
        registerPasswordCell.identify = "registerPasswordID"
        registerInviteCodeCell.identify = "registerInviteCodeID"
        registerAgreedCell.identify = "registerAgreedID"
        registerSubmitCell.identify = "registerSubmitID"
     
        view.addSubview(registerAccountCell)
        view.addSubview(registerSmsCodeCell)
        view.addSubview(registerPasswordCell)
        view.addSubview(registerInviteCodeCell)
        view.addSubview(registerAgreedCell)
        view.addSubview(registerSubmitCell)
        
        registerAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset )
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerSmsCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerAccountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerSmsCodeCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerInviteCodeCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerPasswordCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerAgreedCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerInviteCodeCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        registerSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(registerAgreedCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(35)
        }
        
        registerAccountCell.textBlock = { (key, value) in
            print("registerAccountCell:\(key) ___ value:\(value)")
        }
        
        registerSmsCodeCell.textBlock = { (key, value) in
            print("registerSmsCodeCell:\(key) ___ value:\(value)")
        }
        
        registerPasswordCell.textBlock = { (key, value) in
            print("registerPasswordCell:\(key) ___ value:\(value)")
        }
        
        registerInviteCodeCell.textBlock = { (key, value) in
            print("registerInviteCodeCell:\(key) ___ value:\(value)")
        }
        
        registerAgreedCell.buttonBlock = { (key, value) in
            print("registerAgreedCell:\(key) ___ value:\(value)")
        }
        
        registerSubmitCell.buttonBlock = { (key, value) in
            print("registerSubmitCell:\(key) ___ value:\(value)")
        }
    }
}





















