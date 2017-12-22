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
    
    lazy var authParam: APRealNameAuthRequest = {
        let authParam = APRealNameAuthRequest()
        return authParam
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
        userInputCallBacks()
    }
    
    func userInputCallBacks() {
        
        weak var weakSelf = self
        realNameCell.textBlock = { (key, value) in
            weakSelf?.authParam.name = value
        }
        idCardNoCell.textBlock = {(key, value) in
            weakSelf?.authParam.idNumber = value
        }
    }
}

extension APRealNameAuthViewController {
    
    func layoutViews() {
        
        authHeadMessage.text = "请将身份证放在识别扫描框内，确保证件完整拍摄、无污损、无光斑。"
        
        weak var weakSelf = self
        let idCardFront = APGridViewModel()
        idCardFront.bottomMessage = "身份证正面"
        idCardFront.placeHolderImageName = "auth_idCardFront_normal"
        idCardFront.tapedHandle = {
            
            let viewController = APOCRCameraViewController()
            weakSelf?.present(viewController, animated: true, completion: nil)
        }
        gridViewModels.append(idCardFront)
        
        let idCardResver = APGridViewModel()
        idCardResver.bottomMessage = "身份证反面"
        idCardResver.placeHolderImageName = "auth_idCardResver_normal"
        idCardResver.tapedHandle = {
            CPHD_OCRTool .presentScanIdentify(from: weakSelf, isFront: false, complete: { (identifyInfo) in
                
            }, error: nil)
        }
        gridViewModels.append(idCardResver)
        
        let holdIdCard = APGridViewModel()
        holdIdCard.bottomMessage = "手持身份证半身照片"
        holdIdCard.placeHolderImageName = "auth_holdIdCard_normal"
        holdIdCard.tapedHandle = {
            
            let cameraVC = APTakePhotoCameraViewController()
            weakSelf?.present(cameraVC, animated: true, completion: nil)
        }
        gridViewModels.append(holdIdCard)
        
        let example = APGridViewModel()
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

extension APRealNameAuthViewController {
    
}
