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
class APQRCodePayElementViewController: APQRCodeBaseViewController {
    

    var merchantDetailModel:APMerchantDetail? {
        willSet {
            selectMerchantCell.titleLabel.text = newValue?.dictValue
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        createSubViews()
        resgisterCallBack()
    }

    //MARK: ---- lazy loading
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

extension APQRCodePayElementViewController {
    
    private func createSubViews() {
        
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
        
        //赋值收款金额进行显示
        traAmountCell.textLabel.text = amountStr!
        
    }
    
    private func resgisterCallBack() {
        
        weak var weakSelf = self
        
        selectMerchantCell.buttonBlock = { (key, value) in
            weakSelf?.pushSelectMerchantVC()
        }
        
        submitCell.buttonBlock = { (key, value) in
            let qrCodeVC = APBaseNavigationViewController(rootViewController: APQRCodeCollectionViewController())
            weakSelf?.present(qrCodeVC, animated: true, completion: nil);
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationSelectMerchant(_:)), name: NSNotification.Name(rawValue: "selectMerchant"), object: nil)
    }
    
    @objc func notificationSelectMerchant(_ notif: Notification) {
        self.merchantDetailModel = notif.object as? APMerchantDetail
    }
    
    private func pushSelectMerchantVC() {
        let merchanCV = APSelectMerchantViewController()
        merchanCV.payType = self.payType!
        merchanCV.selectModel = self.merchantDetailModel
        self.navigationController?.pushViewController(merchanCV, animated: true)
    }

}






