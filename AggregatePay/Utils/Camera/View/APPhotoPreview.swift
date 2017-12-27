//
//  APPhotoPreviewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPhotoPreviewManager: NSObject {
    
    let photoPreview = APPhotoPreview()
    public func show(fromController viewController: APBaseViewController, image: UIImage) {
        photoPreview.photo = image
        UIApplication.shared.keyWindow?.addSubview(photoPreview)
        photoPreview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

typealias APPhotoPreviewHandle = (_ isEnsure: Bool) -> Void
class APPhotoPreview: UIView {

    public var photoPreviewHandle: APPhotoPreviewHandle?
    public var photo: UIImage? {
        didSet{
            let leftImage = UIImage.init(cgImage: (photo?.cgImage!)!, scale: (photo?.scale)!, orientation: .right)
            imageView.image = leftImage
        }
    }
    fileprivate let imageView: UIImageView = UIImageView()
    fileprivate var fromViewController: APBaseViewController!
    fileprivate var isStatusBarHidden: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSuvViews()
        isStatusBarHidden = UIApplication.shared.isStatusBarHidden
        UIApplication.shared.isStatusBarHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        UIApplication.shared.isStatusBarHidden = isStatusBarHidden
        print( String(describing: self.classForCoder) + "已释放")
    }
}

extension APPhotoPreview {
    func layoutSuvViews() {
        backgroundColor = UIColor.darkGray
        
        let photoView = UIView()
        photoView.backgroundColor = UIColor.init(hex6: 0xEBEBEB)
        addSubview(photoView)
        
        imageView.contentMode = .scaleAspectFit
//        imageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        photoView.addSubview(imageView)
        
        let ensureButton = UIButton()
        ensureButton.setTitle("使\n用\n照\n片", for: .normal)
        ensureButton.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        ensureButton.titleLabel?.lineBreakMode = .byWordWrapping;
        ensureButton.setTitleColor(UIColor.white, for: .normal)
        ensureButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        ensureButton.addTarget(self, action: #selector(ensure), for: .touchUpInside)
        addSubview(ensureButton)
        
        let rephotographButton = UIButton()
        rephotographButton.setTitle("重\n拍", for: .normal)
        rephotographButton.titleLabel?.lineBreakMode = .byWordWrapping;
        rephotographButton.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        rephotographButton.setTitleColor(UIColor.white, for: .normal)
        rephotographButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        rephotographButton.addTarget(self, action: #selector(rephotograph), for: .touchUpInside)
        addSubview(rephotographButton)
        
        photoView.snp.makeConstraints { (make) in
            let edge = UIEdgeInsets.init(top: camera_preview_top, left: camera_Padding, bottom: camera_RightViewWidth, right: camera_Padding)
            make.edges.equalToSuperview().inset(edge)
        }
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        ensureButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalTo(photoView.snp.right)
            make.width.equalTo(camera_RightViewWidth)
            make.height.equalTo(camera_RightViewWidth)
        }
        rephotographButton.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(ensureButton)
            make.left.equalTo(photoView.snp.left)
        }
    }
    
    @objc func ensure() {
        removeFromSuperview()
        photoPreviewHandle?(true)
    }
    
    @objc func rephotograph() {
        removeFromSuperview()
        photoPreviewHandle?(false)
    }
}
