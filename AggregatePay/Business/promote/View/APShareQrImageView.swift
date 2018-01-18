//
//  APShareQrImageView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APShareQrImageView: UIView {

    var qrCodeImage : UIImage?
    var bgImage = UIImage.init(named: "PromoteTemplate1")
    
    
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
        APQRCodeTool.AP_QRCode(content: url, success: { [weak self] (image) in
            self?.qrCodeImage = image
            self?.updateImage((self?.bgImage)!)
        }) { (error) in
            
        }
    }
    
    func updateImage(_ bgImage : UIImage){
        guard let image = qrCodeImage else { return  }
        bgImageView.image = createQrCodeImage(bgImage, qrCodeImage: image)
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
    
    func createQrCodeImage(_ bgImage : UIImage, qrCodeImage : UIImage) -> UIImage {
        let sourceImage = bgImage
        let imageSize = sourceImage.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        sourceImage.draw(at: CGPoint.init(x: 0, y: 0))
        //获得上下文
        let context = UIGraphicsGetCurrentContext()
        context?.drawPath(using: .fill)
        let sizeScale : CGFloat = 0.3
        let rect = CGRect.init(x: imageSize.width/2.0 - imageSize.width*sizeScale/2.0, y: imageSize.height-imageSize.width*sizeScale - imageSize.height * 0.04, width: imageSize.width*sizeScale, height: imageSize.width*sizeScale)

        context?.clip()
        
        qrCodeImage.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
