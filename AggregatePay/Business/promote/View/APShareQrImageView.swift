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
        bgImageView.image = UIImage.init(named: "推广广告模版1")
        addSubview(bgImageView)
        bgImageView.addSubview(qrCodeImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        qrCodeImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(77)
            make.bottom.equalTo(-24)
            make.centerX.equalToSuperview().offset(0)
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

}
