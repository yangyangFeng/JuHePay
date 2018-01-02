//
//  APShareQrImageView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APShareQrImageView: UIView {

    lazy var bgImageView = UIImageView()
    
    lazy var qrCodeImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgImageView.image = UIImage.init(named: "PromoteTemplate1")
//        bgImageView.contentMode = .bottom
        
        addSubview(bgImageView)
        bgImageView.addSubview(qrCodeImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
            
        }
    }
    
    func changeQrCode(_ url : String){
        APQRCodeTool.AP_QRCode(content: url, success: { (image) in
            qrCodeImageView.image = image
        }) { (error) in
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        qrCodeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo((K_Width*0.2))
            make.bottom.equalToSuperview().offset(-(10/(K_Height*0.62)*(bgImageView.image?.size.height)!))
            make.centerX.equalToSuperview().offset(0)
        }
        
 
    }
}
