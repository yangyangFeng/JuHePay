//
//  APSettlementCardAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSettlementCardAuthViewController: APAuthBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension APSettlementCardAuthViewController {
   private func layoutViews() {
        
        authHeadMessage.text = "结算银行卡为收款到账的银行卡，必须为储蓄卡。"
        
        let nameFormCell = APRealNameFormCell()
        let idCardFormCell = APIdCardNoFormCell()
        let bankCardNoFormCell = APBankCardNoFormCell()
        let bankNameFormCell = APBankNameFormCell()
        
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
        
        let bankImageModel = APGridViewModel()
        bankImageModel.bottomMessage = "上传银行卡照片"
        bankImageModel.imageName = "auth_bankCard_normal"
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
