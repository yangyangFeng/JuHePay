//
//  APLoginViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 登录页面
   1、注册完成之后，手机号默认带过来。
   2、若勾选了记住密码，则下次自动登录无需重新输入登录名，密码。
   3、若退出登录，则默认填写上次登录的手机号，清空密码。
   4、用户名水印：请输入11位手机号码
   5、密码水印：请输入密码
   6、用户名不存在提示：用户名不存在。
   7、密码错误提示：用户名或密码错误。
 */
class APLoginViewController: APSystemBaseViewController {
    
    var logo: UIImageView = UIImageView()
    var loginAccountCell: APLoginAccountCell = APLoginAccountCell()
    var loginPasswordCell: APLoginPasswordCell = APLoginPasswordCell()
    var loginMemoryCell: APLoginMemoryCell = APLoginMemoryCell()
    var loginSubmitCell: APLoginSubmitCell = APLoginSubmitCell()
    var loginToolView: APLoginToolView = APLoginToolView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "商户登录"
        logo.backgroundColor = UIColor.red

        loginAccountCell.identify = "loginAccountID"
        loginPasswordCell.identify = "loginPasswordID"
        loginMemoryCell.identify = "loginMemoryID"
        loginSubmitCell.identify = "loginSubmitID"
        
        view.addSubview(logo)
        view.addSubview(loginAccountCell)
        view.addSubview(loginPasswordCell)
        view.addSubview(loginMemoryCell)
        view.addSubview(loginSubmitCell)
        view.addSubview(loginToolView)
        
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 76, height: 76))
        }
        
        loginAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        loginPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(loginAccountCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        loginMemoryCell.snp.makeConstraints { (make) in
            make.top.equalTo(loginPasswordCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        loginSubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(loginMemoryCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(35)
        }
        loginToolView.snp.makeConstraints { (make) in
            make.top.equalTo(loginSubmitCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(25)
        }
        
        loginAccountCell.textBlock = { (key, value) in
            print("key:\(key) ___ value:\(value)")
        }
        
        loginPasswordCell.textBlock = { (key, value) in
            print("key:\(key) ___ value:\(value)")
        }
        
        loginMemoryCell.buttonBlock = { (key, value) in
            print("loginMemoryCell:\(key) ___ value:\(value)")
        }
        
        loginSubmitCell.buttonBlock = { (key, value) in
            print("loginSubmitCell:\(key) ___ value:\(value)")
        }
        
        loginToolView.gotoRegisterBlock = {(param) in
            print("loginToolView.gotoRegisterBlock:--param:\(param)")
            let registerVC: APRegisterViewController = APRegisterViewController()
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        
        loginToolView.gotoForgetBlock = {(param) in
            print("loginToolView.gotoForgetBlock:--param:\(param)")
            let registerVC: APForgetViewController = APForgetViewController()
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
   
}










