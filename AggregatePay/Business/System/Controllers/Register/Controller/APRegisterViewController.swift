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
    
    var accountFormsCell: APAccountFormsCell = APAccountFormsCell()
    var smsCodeFormsCell: APSMSCodeFormsCell = APSMSCodeFormsCell()
    var passwordFormsCell: APPasswordFormsCell = APPasswordFormsCell()
    var inviteCodeFormsCell: APInviteCodeFormsCell = APInviteCodeFormsCell()
    var registerToolBarView: APRegisterToolBarView = APRegisterToolBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(accountFormsCell)
        view.addSubview(smsCodeFormsCell)
        view.addSubview(passwordFormsCell)
        view.addSubview(inviteCodeFormsCell)
        view.addSubview(registerToolBarView)
        
        accountFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(topOffset)
            make.left.equalTo(view.snp.left).offset(leftOffset )
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        smsCodeFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(accountFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        passwordFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(smsCodeFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        inviteCodeFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(passwordFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        registerToolBarView.snp.makeConstraints { (make) in
            make.top.equalTo(inviteCodeFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
    }
}





















