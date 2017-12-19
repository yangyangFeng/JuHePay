//
//  APRealNameAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRealNameAuthViewController: APAuthBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
    }
}

extension APRealNameAuthViewController {
    func layoutViews() {
        
        authHeadMessage.text = "请将身份证放在识别扫描框内，确保证件完整拍摄、无污损、无光斑。"
        
        let idCardFront = APGridViewModel()
        idCardFront.bottomMessage = "身份证正面"
        idCardFront.imageName = "auth_idCardFront_normal"
        gridViewModels.append(idCardFront)
        
        let idCardResver = APGridViewModel()
        idCardResver.bottomMessage = "身份证反面"
        idCardResver.imageName = "auth_idCardResver_normal"
        gridViewModels.append(idCardResver)
        
        let holdIdCard = APGridViewModel()
        holdIdCard.bottomMessage = "手持身份证半身照片"
        holdIdCard.imageName = "auth_holdIdCard_normal"
        gridViewModels.append(holdIdCard)
        
        let example = APGridViewModel()
        example.bottomMessage = "示例"
        example.gridState = .other
        example.imageName = "auth_example"
        gridViewModels.append(example)
        
        collectionView?.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(cellHeight * 2)
        }
        
        formCellView.snp.updateConstraints({ (make) in
            make.height.equalTo(103)
        })
        
        let realNameCell: APRealNameFormCell = APRealNameFormCell()
        let idCardNoCell: APIdCardNoFormCell = APIdCardNoFormCell()
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
        
        inputTipLabel.snp.updateConstraints { (make) in
            make.height.equalTo(20)
        }
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(inputTipView)
        }
    }
}

extension APRealNameAuthViewController {
    
}
