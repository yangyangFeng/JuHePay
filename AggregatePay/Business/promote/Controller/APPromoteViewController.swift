//
//  APPromoteViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 推广
 */
class APPromoteViewController: APBaseViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vhl_setNavBackgroundColor(UIColor.init(hex6: 0x373737))
  
        title = "推广"
        
        let shareTemplateView =  APShareTemplateBar()
        view.addSubview(shareTemplateView)
        shareTemplateView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(168)
        }
        
        let qrImageView = APShareQrImageView()
        view.addSubview(qrImageView)
        qrImageView.snp.makeConstraints { (make) in
            make.top.equalTo(9)
            make.bottom.equalTo(-12)
            make.centerX.equalToSuperview().offset(0)
        }
        
        qrImageView.changeQrCode("www.baidu.com")
    }

   

}
