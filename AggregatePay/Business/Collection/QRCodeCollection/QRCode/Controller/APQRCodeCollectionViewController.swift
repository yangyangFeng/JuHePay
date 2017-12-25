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
class APQRCodeCollectionViewController: APBaseViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "微信收款"
        view.theme_backgroundColor = ["#3e3e3e"]
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
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
        APQRCodeTool.AP_QRCode(content: "http:baidu.com", success: { (image) in
            qrCodeCollectionView.qrCodeImageView.image = image
        }) { (error) in
            print(error)
        }
    }
    
    @objc func dismissGoHome() {
        self.dismiss(animated: true, completion: nil)
    }
    
}






