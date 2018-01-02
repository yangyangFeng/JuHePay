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
        
        registerObserve()
        
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
            weakSelf?.authParam.bankNo = (weakSelf?.bank?.bankCoupletNum)!
        }
        bankImageModel.tapedHandle = { [weak self] in
            self?.openOCR()
        }
        bankImageModel.setImageComplete = { [weak self] (image) in
            self?.authParam.card = image
        }
    }
    
    private func openOCR() {
        let cameraVC = APCameraViewController()
        cameraVC.delegate = self
        cameraVC.scanCardType = TIDBANK
        cameraVC.supportCameraMode = .all
        present(cameraVC, animated: true, completion: nil)
    }
    
    /// KVO
    
    func registerObserve() {
        
        kvoController.observe(authParam,
                              keyPaths: ["identity", "userName","cardNo", "bankName", "card"],
                              options: .new)
        { [weak self] (_, object, change) in
            
            let model = object as! APSettleCardAuthRequest
            if  model.userName.count > 0 &&
                model.identity.count > 0 &&
                model.cardNo.count > 0 &&
                model.bankName.count > 0 &&
                model.card != nil
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
            
            self?.nameFormCell.textField.text = response.realName
            self?.idCardFormCell.textField.text = aesDecryptString(response.idCard, AP_AES_Key)//response.idCard
            self?.bankCardNoFormCell.textField.text = aesDecryptString(response.cardNo, AP_AES_Key)//response.cardNo
            if response.bankName.count > 0 {
                self?.bankNameFormCell.button.setTitle(response.bankName, for: .normal)
            }
            self?.authParam.bankNo = response.bankNo
            self?.bankImageModel.fileName = response.idCardFront
            
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
                
                APAuthHelper.sharedInstance.settleCardAuthState = .Checking
                self?.controllerTransition()
            })
        }) { [weak self] (error) in
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
        
        let searchBankVC = APBankSearchViewController()
        searchBankVC.selectBankComplete = {[weak self] (bank) in
            self?.bank = bank
            self?.bankNameFormCell.text = bank.bankName
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
        bankCardNoFormCell.textField.text = result.cardNum
        bankImageModel.image = result.bankCardImage
        collectionView.reloadData()
    }
}
