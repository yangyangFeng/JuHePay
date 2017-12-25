//
//  APQRCodePayEssentialViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码的支付要素
 */
class APQRCodePayElementViewController: APBaseViewController {
    
    var selectMccModel:APMCCModel? {
        willSet {
            selectMerchantCell.titleLabel.text = newValue?.mccName
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "微信收款"
        view.backgroundColor = UIColor.groupTableViewBackground
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        
        view.addSubview(traAmountCell)
        view.addSubview(selectMerchantCell)
        view.addSubview(submitCell)
        
        traAmountCell.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.left)
            maker.right.equalTo(view.snp.right)
            maker.top.equalTo(view.snp.top)
            maker.height.equalTo(120)
        }
        
        selectMerchantCell.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.left)
            maker.right.equalTo(view.snp.right)
            maker.top.equalTo(traAmountCell.snp.bottom).offset(20)
            maker.height.equalTo(55)
        }
        
        submitCell.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(selectMerchantCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(44)
        }
        
        weak var weakSelf = self
        selectMerchantCell.buttonBlock = { (key, value) in
            let selectMerchantVC = APSelectMerchantViewController()
            selectMerchantVC.selectMccModel = weakSelf?.selectMccModel
            selectMerchantVC.selectMerchantBlock = {(mccModel) in
                weakSelf?.selectMccModel = mccModel
            }
            weakSelf?.navigationController?.pushViewController(selectMerchantVC, animated: true)
        }
        
        submitCell.buttonBlock = { (key, value) in
            let qrCodeVC = APBaseNavigationViewController(rootViewController: APQRCodeCollectionViewController())
            weakSelf?.present(qrCodeVC, animated: true, completion: nil);
        }
    }
    
   
    
    //MARK: ---- 懒加载
    
    lazy var traAmountCell: APQRCodeTraAmountCell = {
        let view = APQRCodeTraAmountCell()
        return view
    }()
    
    lazy var selectMerchantCell: APQRCodeSelectMerchantCell = {
        let view = APQRCodeSelectMerchantCell()
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("确认收款", for: .normal)
        return view
    }()
    
}







