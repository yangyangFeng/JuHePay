//
//  APSettlementCardAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSettlementCardAuthViewController: APAuthBaseViewController {

    let nameFormCell = APRealNameFormCell()
    let idCardFormCell = APIdCardNoFormCell()
    let bankCardNoFormCell = APBankCardNoFormCell()
    let bankNameFormCell = APBankNameFormCell()
    var bank: APBank?
    var bankImageModel = APGridViewModel()
    
    lazy var authParam: APSettleCardAuthRequest = {
        let authParam = APSettleCardAuthRequest()
        return authParam
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "结算卡认证"
        
        layoutViews()
        
        userInputCallBacks()
        if canEdit {
            registerObserve()
        }
    }
    
    func userInputCallBacks() {
    
        weak var weakSelf = self
        
        nameFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.userName = value
        }
        idCardFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.identity = value
        }
        bankCardNoFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.cardNo = value
        }
        bankCardNoFormCell.tapHandle = { [weak self] in
            self?.openOCR()
        }
        bankNameFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.bankName = value
            weakSelf?.authParam.bankNo = (weakSelf?.bank?.cnapsNo)!
        }
        bankImageModel.tapedHandle = { [weak self] in
            self?.openOCR()
        }
        bankImageModel.setImageComplete = { [weak self] (image) in
            self?.authParam.idCardFront = image
        }
    }
    
    private func openOCR() {
        let cameraVC = APCameraViewController()
        cameraVC.delegate = self
        cameraVC.scanType = .bank
        cameraVC.supportCameraMode = .all
        present(cameraVC, animated: true, completion: nil)
    }
    
    /// KVO
    
    func registerObserve() {
        
        kvoController.observe(authParam,
                              keyPaths: ["identity", "userName","cardNo", "bankName", "idCardFront"],
                              options: .new)
        { [weak self] (_, object, change) in
            
            let model = object as! APSettleCardAuthRequest
            if  model.userName.count > 0 &&
                model.identity.count > 0 &&
                model.cardNo.count > 0 &&
                model.bankName.count > 0 &&
                model.idCardFront != nil
            {
                self?.authSubmitCell.isEnabled = true
            }
            else {
                self?.authSubmitCell.isEnabled = false
            }
        }
    }
    
    override func loadAuthInfo() {
        APAuthHttpTool.settleCardAuthInfo(params: APBaseRequest(), success: { [weak self] (response) in
            
            if .Failure == APAuthState(rawValue: response.authStatus) && response.authDesc.count > 0 {
                self?.showAuthFailureBanner(failureReason: response.authDesc)
            }
            
           self?.nameFormCell.textField.text = response.realName
           self?.authParam.userName = response.realName
            
           self?.idCardFormCell.textField.text = aesDecryptString(response.idCard, AP_AES_Key).cp_stringIDCardByReplacing()
           self?.authParam.identity = aesDecryptString(response.idCard, AP_AES_Key)
            
            self?.bankCardNoFormCell.textField.text = aesDecryptString(response.cardNo, AP_AES_Key).cp_stringBankCardByReplacing()
            self?.authParam.cardNo = aesDecryptString(response.cardNo, AP_AES_Key)
            
            if response.bankName.count > 0 {
                self?.bankNameFormCell.label.text = response.bankName
                self?.authParam.bankName = response.bankName
            }
            self?.authParam.bankNo = response.bankNo
            
            if response.idCardFront.count > 0 {
                self?.bankImageModel.fileName = response.idCardFront
            }
            
            self?.collectionView.reloadData()
            
        }) { [weak self] (error) in
            self?.view.makeToast(error.message)
        }
    }
    
    override func commit() {
        
        if !CPCheckAuthInputInfoTool.evaluateIsLegalName(withName: authParam.userName) {
            view.makeToast("姓名请填写中文")
            return
        }
        
        if authParam.userName.count > 30 {
            view.makeToast("姓名长度出错")
            return
        }
        
        if !CPCheckAuthInputInfoTool.evaluateBankNo(authParam.cardNo) {
            view.makeToast("银行卡号格式不正确")
            return
        }
        
        authSubmitCell.loading(isLoading: true)
        APAuthHttpTool.settleCardAuth(params: authParam, success: { [weak self] (response) in
            self?.authSubmitCell.loading(isLoading: false, isComplete: {
                if APAuthHelper.sharedInstance.settleCardAuthState == .Failure{
                    //更新审核状态
                    APAuthHelper.sharedInstance.settleCardAuthState = .Checking
                    self?.navigationController?.popViewController(animated: true)
                }
                else{
                    //更新审核状态
                    APAuthHelper.sharedInstance.settleCardAuthState = .Checking
                    self?.controllerTransition()
                }
            })
        }) { [weak self] (error) in
            self?.authSubmitCell.loading(isLoading: false)
            self?.view.makeToast(error.message)
        }
    }
    
    func controllerTransition() {
        if let _ = processView() {
            authNavigation()?.pushViewController(APSecurityAuthViewController(), animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension APSettlementCardAuthViewController {
   private func layoutViews() {
        
        headMessageLabel.text = "结算银行卡为收款到账的银行卡，必须为储蓄卡。"
    
        bankNameFormCell.delegate = self
        bankCardNoFormCell.inputRegx = .bankCard
        idCardFormCell.inputRegx = .idCardNo
    
        nameFormCell.enable = false
        idCardFormCell.enable = false
    
        bankCardNoFormCell.enable = canEdit
        bankNameFormCell.enable = canEdit
    
        formCellView.addSubview(nameFormCell)
        formCellView.addSubview(idCardFormCell)
        formCellView.addSubview(bankCardNoFormCell)
        formCellView.addSubview(bankNameFormCell)
    
        nameFormCell.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(50)
        }
        idCardFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(nameFormCell.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(50)
        }
        bankCardNoFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(idCardFormCell.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(50)
        }
        bankNameFormCell.snp.makeConstraints { (make) in
            make.top.equalTo(bankCardNoFormCell.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(50)
        }
        
        formCellView.snp.remakeConstraints { (make) in
            make.top.equalTo(headMessageLabel.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(50 * 4 + 5)
        }
    
        bankImageModel.bottomMessage = "上传银行卡照片"
        bankImageModel.placeHolderImageName = "auth_bankCard_normal"
        bankImageModel.editState = canEdit
        gridViewModels.append(bankImageModel)
        
        collectionView.snp.remakeConstraints({ (make) in
            make.top.equalTo(formCellView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(cellHeight)
        })
        
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(collectionView)
        }
    }
}

extension APSettlementCardAuthViewController: APBankNameFormCellDelegate {
    func bankNameFormCellTaped() {
        
        // MARK 模态视图与键盘冲突
        view.endEditing(true)

        let searchBankVC = APBankSearchViewController()
        searchBankVC.selectBankComplete = {[weak self] (bank) in
            self?.bank = bank
            self?.bankNameFormCell.text = bank.bankName
            self?.authParam.bankNo = bank.cnapsNo
        }
        
        let navi = APBaseNavigationViewController.init(rootViewController: searchBankVC)
        navigationController?.present(navi, animated: true, completion: nil)
    }
}

extension APSettlementCardAuthViewController: APCameraViewControllerDelegate {
    
    func cameraViewController(_ : APCameraViewController, didFinishPickingImage image: UIImage) {
        bankImageModel.image = image
        collectionView.reloadData()
    }
    
    func ocrCameraBankCardResult(bankCard result: APOCRBankCard) {
        
        if let text = result.cardNum {
            bankCardNoFormCell.textField.text = text
            authParam.cardNo = text
        }
        
        if let image = result.bankCardImage {
            bankImageModel.image = image
        }
        collectionView.reloadData()
    }
}
