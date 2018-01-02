//
//  APQRCodeCollectionViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 生成收款二维码视图控制器
 */
class APQRCPCollectionViewController: APBaseViewController {
    
    var qrCodePayResponse: APQRCodePayResponse?
    var getOnlineTransResultRequest = APGetOnlineTransResultRequest()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APNetworking.cancelCurrentRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.theme_backgroundColor = ["#3e3e3e"]
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        createSubviews()
        createQrCodeImage()
        startHttpCollectionResult()
    }
    
    //MARK: ---- action
    @objc func dismissGoHome() {
        self.dismiss(animated: true, completion: nil)
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
        self.perform(#selector(self.httpGetOnlineTransResult),
                     with: nil,
                     afterDelay: 3)
    }
    
    @objc private func httpGetOnlineTransResult() {
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl, action: APHttpService.getOnlineTransResult, params: getOnlineTransResultRequest, aClass: APGetOnlineTransResultResponse.self, success: { (baseResp) in
            
        }, failure: { (baseError) in
            self.perform(#selector(self.httpGetOnlineTransResult),
                         with: nil,
                         afterDelay: 3)
        })
    }
}





