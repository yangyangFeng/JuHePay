//
//  APSecurityAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSecurityAuthViewController: APAuthBaseViewController {

    let nameFormCell = APRealNameFormCell()
    let idCardFormCell = APIdCardNoFormCell()
    let creditCardFormCell = APCreditCardFormCell()
    let phoneNumFormCell = APAuthPhoneNumFormCell()
    
    lazy var authParam: APSecurityAuthRequest = {
        let authParam = APSecurityAuthRequest()
        return authParam
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "安全认证"
        layoutViews()
        userInputCallBacks()
        registerObserve()
    }
    
    func userInputCallBacks() {
        weak var weakSelf = self
        nameFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.userName = value
        }
        idCardFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.idCard = value
        }
        creditCardFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.cardNo = value
        }
        creditCardFormCell.tapHandle = { [weak self] in
            self?.openOCR()
        }
        phoneNumFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.mobileNo = value
        }
    }
    
    private func openOCR() {
        let cameraVC = APCameraViewController()
        cameraVC.delegate = self
        cameraVC.scanCardType = TIDBANK
        cameraVC.supportCameraMode = .all
        present(cameraVC, animated: true, completion: nil)
    }
    
    
    func registerObserve() {
        
        kvoController.observe(authParam,
                              keyPaths: ["idCard", "userName","cardNo", "mobileNo"],
                              options: .new)
        { [weak self] (_, object, change) in
            
            let model = object as! APSecurityAuthRequest
            if  model.userName.count > 0 &&
                model.idCard.count > 0 &&
                model.cardNo.count > 0 &&
                model.mobileNo.count > 0
            {
                self?.authSubmitCell.isEnabled = true
            }
            else {
                self?.authSubmitCell.isEnabled = false
            }
        }
    }
    
    override func loadAuthInfo() {
        APAuthHttpTool.securityAuthInfo(params: APBaseRequest(), success: { [weak self] (response) in
            
            if .Failure == APAuthState(rawValue: response.authStatus) && response.authDesc.count > 0 {
                self?.showAuthFailureBanner(failureReason: response.authDesc)
            }
            
            self?.nameFormCell.textField.text = response.realName
            self?.authParam.userName = response.realName
            
            self?.idCardFormCell.textField.text = aesDecryptString(response.idCard, AP_AES_Key)
            self?.authParam.idCard = aesDecryptString(response.idCard, AP_AES_Key)
            
            self?.creditCardFormCell.textField.text = aesDecryptString(response.cardNo, AP_AES_Key)
            self?.authParam.cardNo = aesDecryptString(response.cardNo, AP_AES_Key)
            
            self?.phoneNumFormCell.textField.text = response.bankMobile
            self?.authParam.mobileNo = response.bankMobile
            
        }) { [weak self] (error) in
            self?.view.makeToast(error.message)
        }
    }
    override func commit() {
        
        if !CPCheckAuthInputInfoTool.evaluateIsChineseAndEnglishName(withName: authParam.userName) {
            view.makeToast("姓名请填写中文")
            return
        }
        if authParam.userName.count > 30 {
            view.makeToast("姓名长度出错")
            return
        }
        if !CPCheckAuthInputInfoTool.evaluatePhoneNumber(authParam.mobileNo) {
            view.makeToast("手机号格式不正确")
            return
        }
        
        if !CPCheckAuthInputInfoTool.checkIsIDCard(withIDCard: authParam.idCard) {
            view.makeToast("身份证号格式错误，请输入正确的身份证号")
            return
        }
        if !CPCheckAuthInputInfoTool.checkIsMoreThan18(withCardNo: authParam.idCard) {
            view.makeToast("平台用户必须年满18周岁，请重新输入")
            return
        }
        
        authSubmitCell.loading(isLoading: true)
        APAuthHttpTool.securityAuth(params: authParam, success: { [weak self] (response) in
            self?.authSubmitCell.loading(isLoading: false, isComplete: {
                APAuthHelper.sharedInstance.securityAuthState = .Checking
                self?.controllerTransition()
            })
        }) {[weak self] (error) in
             self?.authSubmitCell.loading(isLoading: false)
            self?.view.makeToast(error.message)
        }
    }
    
    func controllerTransition() {
        if let _ = processView() {
            let navi = authNavigation()
            navi?.finishAuths?()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension APSecurityAuthViewController {
    
    // MARK: -- UI
    fileprivate func layoutViews() {
        
        headMessageLabel.text = "为保障您的支付安全,请进行信用卡认证。"
        idCardFormCell.inputRegx = .idCardNo
        creditCardFormCell.inputRegx = .bankCard
        phoneNumFormCell.inputRegx = .mobile
        
        // 永远都不能修改
        nameFormCell.enable = false
        idCardFormCell.enable = false
        
        creditCardFormCell.enable = canEdit
        phoneNumFormCell.enable = canEdit
        
        formCellView.addSubview(nameFormCell)
        formCellView.addSubview(idCardFormCell)
        formCellView.addSubview(creditCardFormCell)
        formCellView.addSubview(phoneNumFormCell)
        
        nameFormCell.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-2)
            make.height.equalTo(50)
        }
        idCardFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(nameFormCell.snp.bottom).offset(1)
            make.left.right.height.equalTo(nameFormCell)
        }
        creditCardFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(idCardFormCell.snp.bottom).offset(1)
            make.left.right.height.equalTo(idCardFormCell)
        }
        phoneNumFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(creditCardFormCell.snp.bottom)
            make.left.right.height.equalTo(creditCardFormCell)
        }
        formCellView.snp.remakeConstraints { (make) in
            make.top.equalTo(headMessageLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(4 * 50 + 5)
        }
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(formCellView.snp.bottom)
        }
    }
}

extension APSecurityAuthViewController: APCameraViewControllerDelegate {
    
    func ocrCameraBankCardResult(bankCard result: APOCRBankCard) {
        creditCardFormCell.textField.text = result.cardNum
    }
    
}
