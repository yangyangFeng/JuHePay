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
    
    let loginRequest: APLoginRequest = APLoginRequest()

    //MARK: ---- life cycle
    
    override func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "sys_nav_back_icon")
        return image!.withRenderingMode(.alwaysOriginal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商户登录"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        createSubviews()
        registerCallBacks()
        registerObserve()
        
        //获取缓存的数据
        let account = APUserDefaultCache.AP_get(key: .mobile) as! String
        let password = APUserDefaultCache.AP_get(key: .password)  as! String
        
        if account != "" {
            self.accountCell.textField.text = account
            self.loginRequest.mobileNo = account
        }
        if password != "" {
            self.passwordCell.textField.text = password
            self.loginRequest.passwd = password
        }
        
        if account != "" && password != "" {
            self.memoryCell.button.isSelected = true
        }
    }
    
    //MARK: ----- action
    @objc func dismissGoHome() {
        self.dismiss(animated: true, completion: nil)
    }

   
    //MARK: ---- lazy loading
    lazy var toolView: APLoginToolView = {
        let view = APLoginToolView()
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var accountCell: APTextFormsCell = {
        let view = APTextFormsCell()
        view.inputRegx = .mobile
        view.textField.keyboardType = UIKeyboardType.numberPad
        view.textField.placeholder = "请输入11位手机号码"
        return view
    }()
    
    lazy var passwordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请输入密码"
        return view
    }()
    
    lazy var memoryCell: APSelectBoxFormsCell = {
        let view = APSelectBoxFormsCell()
        view.button.setTitle(_ : " 记住密码", for: .normal)
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("登录", for: .normal)
        return view
    }()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(image: AP_navigationLeftItemImage(),
                                   style: UIBarButtonItemStyle.done,
                                   target: self,
                                   action: #selector(dismissGoHome))
        return view
    }()
   
}

extension APLoginViewController {
    
    //MARK: ----- private
    private func createSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(accountCell)
        view.addSubview(passwordCell)
        view.addSubview(memoryCell)
        view.addSubview(submitCell)
        view.addSubview(toolView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.size.equalTo(CGSize(width: 76, height: 76))
        }
        
        accountCell.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
        
        passwordCell.snp.makeConstraints { (make) in
            make.top.equalTo(accountCell.snp.bottom)
            make.left.right.height.equalTo(accountCell)
        }
        
        memoryCell.snp.makeConstraints { (make) in
            make.top.equalTo(passwordCell.snp.bottom)
            make.left.right.height.equalTo(accountCell)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.top.equalTo(memoryCell.snp.bottom).offset(20)
            make.left.right.equalTo(accountCell)
            make.height.equalTo(41)
        }
        
        toolView.snp.makeConstraints { (make) in
            make.top.equalTo(submitCell.snp.bottom).offset(20)
            make.left.right.equalTo(submitCell)
            make.height.equalTo(25)
        }
    }
    
    private func registerCallBacks() {
        
        weak var weakSelf = self
        
        accountCell.textBlock = { (key, value) in
            weakSelf?.loginRequest.mobileNo = value
        }
        
        passwordCell.textBlock = { (key, value) in
            weakSelf?.loginRequest.passwd = value
        }
        
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.login()
        }
        
        toolView.gotoForgetBlock = {(param) in
            let registerVC: APForgetFirstStepViewController = APForgetFirstStepViewController()
            weakSelf?.navigationController?.pushViewController(registerVC, animated: true)
        }
        
        toolView.gotoRegisterBlock = {(param) in
            let registerVC: APRegisterViewController = APRegisterViewController()
            weakSelf?.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    
    private func registerObserve() {
        weak var weakSelf = self
        self.kvoController.observe(self.loginRequest,
                                   keyPaths: ["mobileNo",
                                              "passwd"],
                                   options: [.new, .initial])
        { (observer, object, change) in
            let loginModel = object as! APLoginRequest
            if  loginModel.mobileNo.characters.count >= 11 &&
                loginModel.passwd.characters.count >= 6{
                weakSelf?.submitCell.isEnabled = true
            }
            else {
                weakSelf?.submitCell.isEnabled = false
            }
        }
    }
    
    private func startCacheData(loginResponse: APLoginResponse) {
        APUserDefaultCache.AP_set(value: loginResponse.userId!, key: .userId)
        //判断是否需要记住密码(利用UserDefaultCache进行缓存)
        if  memoryCell.button.isSelected {
            let mobile = loginRequest.mobileNo
            let password = loginRequest.passwd
            APUserDefaultCache.AP_set(value: mobile, key: .mobile)
            APUserDefaultCache.AP_set(value: password, key: .password)
        }
        else {
            APUserDefaultCache.AP_set(value: "", key: .mobile)
            APUserDefaultCache.AP_set(value: "", key: .password)
        }
    }
    
    private func login() {
        if !self.loginRequest.mobileNo.evaluate(regx: .mobile) {
            self.view.makeToast("手机号输入格式不正确")
            return
        }
        submitCell.loading(isLoading: true, isComplete: nil)
        APSystemHttpTool.login(paramReqeust: loginRequest, success: { (baseResp) in
            self.startCacheData(loginResponse: baseResp as! APLoginResponse)
            self.submitCell.loading(isLoading: false, isComplete: nil)
            self.dismiss(animated: true, completion: nil)
        }) { (errorMsg) in
            self.submitCell.loading(isLoading: false, isComplete: nil)
            self.view.makeToast(errorMsg)
        }
    }
}








