//
//  APRealNameAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRealNameAuthViewController: APAuthBaseViewController {
    
    let realNameCell = APRealNameFormCell()
    let idCardNoCell = APIdCardNoFormCell()
    
    let idCardFront = APGridViewModel()
    let idCardResver = APGridViewModel()
    let holdIdCard = APGridViewModel()
    let example = APGridViewModel()
    
    lazy var authParam: APRealNameAuthRequest = {
        let authParam = APRealNameAuthRequest()
        return authParam
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "实名认证"

        layoutViews()
        registerCallBacks()
    }
    
    override func registerCallBacks() {
        super.registerCallBacks()
        
        realNameCell.textBlock = {[weak self] (key, value) in
            self?.authParam.realName = value
        }
        idCardNoCell.textBlock = {[weak self] (key, value) in
            self?.authParam.idCard = value
        }
        
        idCardFront.tapedHandle = { [weak self] in
            let cameraVC = APCameraViewController()
            cameraVC.delegate = self
            cameraVC.scanCardType = TIDCARD2
            cameraVC.supportCameraMode = .all
            self?.present(cameraVC, animated: true, completion: nil)
        }
        
        idCardResver.tapedHandle = {[weak self] in
            let cameraVC = APCameraViewController()
            cameraVC.delegate = self
            cameraVC.supportCameraMode = .takePhoto
            self?.present(cameraVC, animated: true, completion: nil)
        }
        
        holdIdCard.tapedHandle = {[weak self] in
            let cameraVC = APCameraViewController()
            cameraVC.delegate = self
            cameraVC.supportCameraMode = .takePhoto
            self?.present(cameraVC, animated: true, completion: nil)
        }
    }
    
    override func commit() {
        if let _ = processView() {
            authNavigation()?.pushViewController(APSettlementCardAuthViewController(), animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension APRealNameAuthViewController {
    
    func layoutViews() {
        
        authHeadMessage.text = "请将身份证放在识别扫描框内，确保证件完整拍摄、无污损、无光斑。"
        
        idCardFront.bottomMessage = "身份证正面"
        idCardFront.placeHolderImageName = "auth_idCardFront_normal"
        gridViewModels.append(idCardFront)
        
        idCardResver.bottomMessage = "身份证反面"
        idCardResver.placeHolderImageName = "auth_idCardResver_normal"
        gridViewModels.append(idCardResver)
        
       
        holdIdCard.bottomMessage = "手持身份证半身照片"
        holdIdCard.placeHolderImageName = "auth_holdIdCard_normal"
        gridViewModels.append(holdIdCard)
        
        
        example.bottomMessage = "示例"
        example.gridState = .other
        example.placeHolderImageName = "auth_example"
        gridViewModels.append(example)
        
        collectionView?.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(cellHeight * 2)
        }
        
        formCellView.snp.updateConstraints({ (make) in
            make.height.equalTo(103)
        })
        
        realNameCell.backgroundColor = UIColor.white
        idCardNoCell.backgroundColor = UIColor.white
        formCellView.addSubview(realNameCell)
        formCellView.addSubview(idCardNoCell)
        realNameCell.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(50)
        }
        idCardNoCell.snp.makeConstraints { (make) in
            make.top.equalTo(realNameCell.snp.bottom).offset(1)
            make.right.left.height.equalTo(realNameCell)
        }
        
        inputTipView.snp.updateConstraints { (make) in
            make.height.equalTo(20)
        }
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(inputTipView)
        }
    }
}

extension APRealNameAuthViewController: APCameraViewControllerDelegate {
    
    func cameraViewController(_ : APCameraViewController, didFinishPickingImage image: UIImage) {
        updateGridImage(image: image)
    }
    func ocrCameraIDCardResult(IDCard result: APOCRIDCard) {
        updateGridImage(image: result.image)
        if let text = result.name {
            realNameCell.textField.text = text
        }
        if let text = result.number {
            idCardNoCell.textField.text = text
        }
    }
    
    func updateGridImage(image: UIImage?) {
        if let model = currentGridModel {
            model.image = image
            collectionView?.performBatchUpdates({
                let indexPath = IndexPath.init(item: gridViewModels.index(of: model)!, section: 0)
                collectionView?.reloadItems(at:[indexPath as IndexPath])
            }, completion: nil)
        }
    }
}
