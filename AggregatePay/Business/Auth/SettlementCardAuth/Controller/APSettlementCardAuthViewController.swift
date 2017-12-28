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
    }
    
    func userInputCallBacks() {
    
        weak var weakSelf = self
        
        nameFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.name = value
        }
        idCardFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.identityCard = value
        }
        bankCardNoFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.accountNo = value
        }
        bankNameFormCell.textBlock = {(key, value) in
            weakSelf?.authParam.bankName = value
            weakSelf?.authParam.unionBankNo = (weakSelf?.bank?.bankName)!
        }
    }
    
    override func commit() {
        if let _ = processView() {
            authNavigation()?.pushViewController(APSecurityAuthViewController(), animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension APSettlementCardAuthViewController {
   private func layoutViews() {
        
        authHeadMessage.text = "结算银行卡为收款到账的银行卡，必须为储蓄卡。"
    
        bankNameFormCell.delegate = self
        weak var weakSelf = self
    
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
            make.top.equalTo(authHeadMessage.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(50 * 4 + 5)
        }
    
        bankImageModel.bottomMessage = "上传银行卡照片"
        bankImageModel.placeHolderImageName = "auth_bankCard_normal"
        bankImageModel.tapedHandle = {
            let cameraVC = APCameraViewController()
            cameraVC.delegate = weakSelf
            cameraVC.scanCardType = TIDBANK
            cameraVC.supportCameraMode = .all
            weakSelf?.present(cameraVC, animated: true, completion: nil)
            
        }
        gridViewModels.append(bankImageModel)
        
        collectionView?.snp.remakeConstraints({ (make) in
            make.top.equalTo(formCellView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(cellHeight)
        })
        
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(collectionView!)
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
        collectionView?.reloadData()
    }
    
    func ocrCameraBankCardResult(bankCard result: APOCRBankCard) {
        bankCardNoFormCell.textField.text = result.cardNum
        bankImageModel.image = result.bankCardImage
        collectionView?.reloadData()
    }
}
