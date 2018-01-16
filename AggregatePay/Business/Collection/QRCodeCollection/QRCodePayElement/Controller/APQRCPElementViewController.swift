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
class APQRCPElementViewController: APQRCPBaseViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NOTIFICA_SELECT_MERCHANT_KEY, object: nil)
    }

    var merchantDetailModel:APMerchantDetail? {
        willSet {
            selectMerchantCell.titleLabel.text = newValue?.dictKey
            qrCodePayRequest.categroyCode = newValue?.dictValue
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        
        createSubViews()
        resgisterCallBack()
    }
    
    @objc func notificationSelectMerchant(_ notif: Notification) {
        self.merchantDetailModel = notif.object as? APMerchantDetail
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

extension APQRCPElementViewController {
    
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
            weakSelf?.pushQRCPSelectMerchantVC()
        }
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.startHttpGetQRCode()
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notificationSelectMerchant(_:)),
                                               name: NOTIFICA_SELECT_MERCHANT_KEY,
                                               object: nil)
    }
}

extension APQRCPElementViewController {
    
    private func pushQRCPSelectMerchantVC() {
        let qrcpSeleMerchanCV = APQRCPSeleMerchantViewController()
        qrcpSeleMerchanCV.payType = payType!
        qrcpSeleMerchanCV.selectModel = merchantDetailModel
        self.navigationController?.pushViewController(qrcpSeleMerchanCV, animated: true)
    }
    
    private func presentQRCPCollectionVC(qrCodePayResponse: APQRCodePayResponse) {
        let qrcpCollectionCV = APQRCPCollectionViewController()
        qrcpCollectionCV.qrCodePayResponse = qrCodePayResponse
        qrcpCollectionCV.title = title
        qrcpCollectionCV.payType = payType
        qrcpCollectionCV.amountStr = amountStr
        let navigation = APBaseNavigationViewController(rootViewController: qrcpCollectionCV)
        self.present(navigation, animated: true, completion: nil);
    }
    
    private func startHttpGetQRCode() {
        qrCodePayRequest.transAmount = String((Double(amountStr!)! * 100))
        qrCodePayRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        view.AP_loadingBegin()
        submitCell.loading(isLoading: true, isComplete: nil)
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: payService!,
                          params: qrCodePayRequest,
                          aClass: APQRCodePayResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
                            self.submitCell.loading(isLoading: false, isComplete: {
                                let qrCodePayResponse = baseResp as! APQRCodePayResponse
                                self.presentQRCPCollectionVC(qrCodePayResponse: qrCodePayResponse)
                            })
        }, failure: {(baseError) in
            self.submitCell.loading(isLoading: false, isComplete: nil)
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
}






