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
class APPromoteViewController: APBaseViewController,AP_ActionProtocol {

    
    var qrImageView = APShareQrImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vhl_setNavBackgroundColor(UIColor.init(hex6: 0x373737))
        view.theme_backgroundColor = ["#2b2b2b"]
        title = "推广"
        
        let shareTemplateView =  APShareTemplateBar()
        shareTemplateView.theme_backgroundColor = ["#222222"]
        shareTemplateView.delegate = self
        view.addSubview(shareTemplateView)
        shareTemplateView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(168)
        }
        
        view.addSubview(qrImageView)
        qrImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(9)
            make.width.equalTo(K_Width*0.6)
            make.top.equalTo(9)
//            equalToSuperview().offset(9)
//            make.height.equalTo(K_Width*0.6*1.8)
            //(((414)*(qrImageView.bgImageView.image?.size.width)!/(qrImageView.bgImageView.image?.size.height)!))
            make.bottom.equalTo(shareTemplateView.snp.top).offset(-12)
            make.centerX.equalToSuperview().offset(0)
            
        }
//        qrImageView.bgImageView.image = shareTemplateView.templateImageIndex
        qrImageView.changeQrCode("www.baidu.com")
        
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.init(hex6: 0xc8a556), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("分享", for: UIControlState.normal)
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(shareAction(_:)), for: UIControlEvents.touchUpInside)
        let shareButtonItem = UIBarButtonItem.init(customView: button)
        navigationItem.rightBarButtonItem = shareButtonItem
    }

    func AP_Action_Click(_ obj: Any) {
        qrImageView.bgImageView.image = obj as? UIImage
//        qrImageView.snp.updateConstraints { (make) in
//            make.width.equalTo(qrImageView.size.height / 1.8)
////                ((414)*(qrImageView.bgImageView.image?.size.width)!/(qrImageView.bgImageView.image?.size.height)!))
//        }
    }
    


    @objc func shareAction(_ btn : UIButton)
    {
        ap_userIdentityStatus {
            let shareC : APShareViewController = APShareViewController()
            shareC.shareImage = self.qrImageView.screenshot
            self.navigationController?.pushViewController(shareC)
        }
    }
    
    
}
