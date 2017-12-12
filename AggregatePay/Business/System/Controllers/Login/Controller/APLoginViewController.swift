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
class APLoginViewController: APSystemBaseViewController, APLoginToolBarViewDelegate {
    
    var accountFormsCell: APAccountFormsCell = APAccountFormsCell()
    var passwordFormsCell: APPasswordFormsCell = APPasswordFormsCell()
    var loginToolBarCell: APLoginToolBarView = APLoginToolBarView()
    var register: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginToolBarCell.delegate = self
        
        register.titleLabel?.textAlignment = .center
        register.setTitle(_ : "注册", for: .normal)
        register.setTitleColor(_ : UIColor.black, for: .normal)
        register.addTarget(self,
                           action: #selector(clickRegisterVC),
                           for: .touchUpInside)
        
        view.addSubview(accountFormsCell)
        view.addSubview(passwordFormsCell)
        view.addSubview(loginToolBarCell)
        view.addSubview(register)
        
        accountFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(topOffset)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        passwordFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(accountFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        loginToolBarCell.snp.makeConstraints { (make) in
            make.top.equalTo(passwordFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        register.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
    }
    
    // 点击注册按钮
    @objc func clickRegisterVC() {
        
        let registerVC: APRegisterViewController = APRegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    //MARK: --------- APLoginToolBarViewDelegate
    
    
    func onDidMemory() {
        
    }
    
    func onDidForget() {
        let forget: APForgetViewController = APForgetViewController()
        self.navigationController?.pushViewController(forget, animated: true)
    }


}










