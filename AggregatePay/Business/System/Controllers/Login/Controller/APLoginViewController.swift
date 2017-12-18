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
    
    //MARK: ------------- 全局属性
    
    let logoImageView: UIImageView = UIImageView()
    let loginToolView: APLoginToolView = APLoginToolView()
    let loginRequest: APLoginRequest = APLoginRequest()
    
    lazy var loginAccountCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = "^1[0-9]{0,10}$"
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入11位手机号码"
        return view
    }()
    
    lazy var loginPasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = "^[A-Za-z0-9-_]{0,20}$"
        view.textField.placeholder = "请输入密码"
        return view
    }()
    
    lazy var loginMemoryCell: APSelectBoxFormsCell = {
        let view = APSelectBoxFormsCell()
        view.button.setTitle(_ : " 记住密码", for: .normal)
        return view
    }()
    
    lazy var loginSubmitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("登录", for: .normal)
        return view
    }()
    
    //MARK: ------------- 生命周期

    override func viewDidLoad() {
        super.viewDidLoad()
        //注意：私有方法调用顺序 (系统配置->创建子视图->子视图布局->监听子视图回调->注册通知)
        loginSystemConfig()
        loginCreateSubViews()
        loginLayoutSubViews()
        loginTargetCallBacks()
        loginRegisterObserve()
    }
    
    //MARK: ------------- 私有方法
    
    private func loginSystemConfig() {
        
        self.title = "商户登录"
        self.logoImageView.backgroundColor = UIColor.red
    }
    
    private func loginCreateSubViews() {
        
        view.addSubview(logoImageView)
        view.addSubview(loginAccountCell)
        view.addSubview(loginPasswordCell)
        view.addSubview(loginMemoryCell)
        view.addSubview(loginSubmitCell)
        view.addSubview(loginToolView)
    }
    
    private func loginLayoutSubViews() {
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 76, height: 76))
        }
        
        loginAccountCell.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
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
            make.height.equalTo(subimtHeight)
        }
        
        loginToolView.snp.makeConstraints { (make) in
            make.top.equalTo(loginSubmitCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(25)
        }
        
    }
    
    private func loginTargetCallBacks() {
        
        weak var weakSelf = self
        
        loginAccountCell.textBlock = { (key, value) in
            weakSelf?.loginRequest.mobile = value
        }
        
        loginPasswordCell.textBlock = { (key, value) in
            weakSelf?.loginRequest.password = value
        }
        
        loginMemoryCell.buttonBlock = { (key, value) in
            print("loginMemoryCell:\(key) ___ value:\(value)")
        }
        
        
        loginSubmitCell.buttonBlock = { (key, value) in
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        
        loginToolView.gotoRegisterBlock = {(param) in
            print("loginToolView.gotoRegisterBlock:--param:\(param)")
            let registerVC: APRegisterViewController = APRegisterViewController()
            weakSelf?.navigationController?.pushViewController(registerVC, animated: true)
        }
        
        loginToolView.gotoForgetBlock = {(param) in
            print("loginToolView.gotoForgetBlock:--param:\(param)")
            let registerVC: APForgetFirstStepViewController = APForgetFirstStepViewController()
            weakSelf?.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    private func loginRegisterObserve() {
        weak var weakSelf = self
        self.kvoController.observe(self.loginRequest,
                                   keyPaths: ["mobile", "password"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let loginModel = object as! APLoginRequest
            if  loginModel.mobile.characters.count >= 11 &&
                loginModel.password.characters.count >= 6{
                weakSelf?.loginSubmitCell.isEnabled = true
            }
            else {
                weakSelf?.loginSubmitCell.isEnabled = false
            }
        }
    }
   
}










