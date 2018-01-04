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
class APQRCPCollectionViewController: APBaseViewController {
    
    var isCancelRequest: Bool = false
    var qrCodePayResponse: APQRCodePayResponse?
    var getOnlineTransResultRequest = APGetOnlineTransResultRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isCancelRequest = false
        view.theme_backgroundColor = ["#3e3e3e"]
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        createSubviews()
        createQrCodeImage()
        startHttpCollectionResult()
    }
    
    //MARK: ---- action
    @objc func dismissGoHome() {
        isCancelRequest = true
        APNetworking.cancelCurrentRequest()
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
        
        let parameters = getOnlineTransResultRequest.mj_keyValues() as! Dictionary<String, Any>
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        var requestHeader: HTTPHeaders?
        if cookie != "" {
            requestHeader = ["cookie":cookie]
        }
        
         APNetworking.sharedInstance.request(httpUrl: APHttpUrl.trans_httpUrl,
                                            action: APHttpService.getOnlineTransResult,
                                            method: .post,
                                            headers: requestHeader,
                                            timeOut: 30,
                                            parameters: parameters,
                                            success: { (result) in
                                               self.httpResponse(result: result)
        }) { (error) in
            self.httpError()
        }
    }
    
    func httpResponse(result: Dictionary<String, Any>) {
        if !result.keys.contains("isSuccess") {
            httpError()
        }
        else {
           
        }
    }
    
    func httpError() {
        if !self.isCancelRequest {
            self.perform(#selector(self.httpGetOnlineTransResult),
                         with: nil,
                         afterDelay: 3)
        }
    }
}





