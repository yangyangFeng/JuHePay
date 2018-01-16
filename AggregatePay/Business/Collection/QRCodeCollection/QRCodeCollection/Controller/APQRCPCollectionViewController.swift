//
//  APQRCodeCollectionViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import Alamofire

/**
 * 生成收款二维码视图控制器
 */
class APQRCPCollectionViewController: APQRCPBaseViewController {
    
    deinit {
        print("---------页面释放")
        NotificationCenter.default.removeObserver(self, name: NOTIFICA_ENTER_BACKGROUND_KEY,                                                  object: nil)
    }
    
    var isCancelRequest: Bool = false
    var qrCodePayResponse: APQRCodePayResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.theme_backgroundColor = ["#3e3e3e"]
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        displayViewAtData()
        createSubviews()
        createQrCodeImage()
        startHttpCollectionResult()
        registerNotification()
    }
    
    func displayViewAtData() {
        qrCodeCollectionView.navBarTitleLabel.text = qrCodeNavTitle
        qrCodeCollectionView.merchantTitleLabel.text = "商家:" + (qrCodePayResponse?.merchantName)! + "向您发起收款"
        let createDate = qrCodePayResponse?.createDate
        let validTime = qrCodePayResponse?.validTime
        let limitDate: String = "生成于" + createDate! + ",有效期" + validTime! + "分钟"
        qrCodeCollectionView.dateLimitLabel.text = limitDate
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificEnterBackground(_:)), name: NOTIFICA_ENTER_BACKGROUND_KEY, object: nil)
    }
    
    @objc func notificEnterBackground(_ notif: Notification) {
        dismissGoHome()
    }
    
    //MARK: ---- action
    @objc func dismissGoHome() {
        self.removeActivityData()
        let tabBarC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
        let selectVC = tabBarC.selectedViewController as! APBaseNavigationViewController
        let lastVC = selectVC.childViewControllers.last as! APBaseViewController
        lastVC.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
   
    func removeActivityData() {
        isCancelRequest = true
        APNetworking.cancelCurrentRequest()
    }
    
    //MARK: ---- lazy loading
    lazy var qrCodeCollectionView: APQRCodeCollectionView = {
        let view = APQRCodeCollectionView()
        return view
    }()
    
    lazy var qrCodeDescribeLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.theme_textColor = ["#d09326"]
        view.font = UIFont.systemFont(ofSize: 12.0)
        view.text = "凡任何以兼职、信用卡套现、养卡、提额、淘宝刷单为由要求付款的均属诈骗，请在支付前谨慎确认。"
        return view
    }()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "完成",
                                   style: UIBarButtonItemStyle.done,
                                   target: self,
                                   action: #selector(dismissGoHome))
        return view
    }()

}

extension APQRCPCollectionViewController {
    
    private func createSubviews() {
        view.addSubview(qrCodeCollectionView)
        view.addSubview(qrCodeDescribeLabel)
        qrCodeDescribeLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.left).offset(40)
            maker.right.equalTo(view.snp.right).offset(-40)
            maker.bottom.equalTo(view.snp.bottom).offset(-80)
        }
        qrCodeCollectionView.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.left).offset(40)
            maker.right.equalTo(view.snp.right).offset(-40)
            maker.top.equalTo(view.snp.top).offset(50)
            maker.bottom.equalTo(qrCodeDescribeLabel.snp.top).offset(-20)
        }
    }
    
    private func createQrCodeImage() {
        APQRCodeTool.AP_QRCode(content: (qrCodePayResponse?.codeUrl!)!, success: { (image) in
            qrCodeCollectionView.qrCodeImageView.image = image
        }) { (error) in
            print(error)
        }
    }
}

extension APQRCPCollectionViewController {

    
    private func startHttpCollectionResult() {
        if !self.isCancelRequest {
            self.perform(#selector(self.httpGetOnlineTransResult),
                         with: nil,
                         afterDelay: 3)
        }
    }
    
    @objc private func httpGetOnlineTransResult() {
        
        let getOnlineTransResultRequest = APGetOnlineTransResultRequest()
        getOnlineTransResultRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        getOnlineTransResultRequest.innerOrderNo = qrCodePayResponse?.innerOrderNo
        getOnlineTransResultRequest.terminalNo = qrCodePayResponse?.terminalNo
        getOnlineTransResultRequest.orderNo = qrCodePayResponse?.orderNo
        getOnlineTransResultRequest.merchantNo = qrCodePayResponse?.merchantNo
        APNetworking.get(httpUrl: APHttpUrl.trans_httpUrl,
                         action: APHttpService.getOnlineTransResult,
                         params: getOnlineTransResultRequest,
                         aClass: APGetOnlineTransResultResponse.self,
                         success:
            { (baseResp) in
            let result = baseResp as! APGetOnlineTransResultResponse
            if result.status == "2" {
                self.onSuccess(result: result)
            }
            else if result.status == "3" {
                self.onFaiure(result: result)
            }
            else {
                self.startHttpCollectionResult()
            }
        }, failure: {(baseError) in
            self.startHttpCollectionResult()
        })
    }
   
    func onSuccess(result: APGetOnlineTransResultResponse) {
        self.dismiss(animated: true, completion: nil)
        let successVC = APCollectionSuccessViewController()
        successVC.resultDic = ["orderNo":result.orderNo!,
                               "transDateTime":result.transDateTime!,
                               "transAmount":result.transAmount!,
                               "payServiceCode":payServiceCode!]
        let navigation = APBaseNavigationViewController(rootViewController: successVC)
        let lastVC = APPDElEGATE.window?.rootViewController?.childViewControllers.last
        lastVC?.present(navigation, animated: true, completion: nil);
    }
    
    func onFaiure(result: APGetOnlineTransResultResponse) {
        self.dismiss(animated: true, completion: nil)
        let failureVC = APCollectionFailureViewController()
        failureVC.resultDic = ["respDesc":result.respDesc!]
        let navigation = APBaseNavigationViewController(rootViewController: failureVC)
        let lastVC = APPDElEGATE.window?.rootViewController?.childViewControllers.last
        lastVC?.present(navigation, animated: true, completion: nil);
    }
}





