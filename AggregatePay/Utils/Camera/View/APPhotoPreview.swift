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
    
    fileprivate var maxScale: CGFloat = 2.0
    fileprivate var minScale: CGFloat = 1.0
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
        scrollView.delegate = self
        scrollView.addGestureRecognizer(doubleTapGesture)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    private lazy var photoView: UIView = {
        let photoView = UIView()
        photoView.backgroundColor = UIColor.init(hex6: 0xEBEBEB)
        return photoView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var ensureButton: UIButton = {
        let button = UIButton()
        button.setTitle("使\n用\n照\n片", for: .normal)
        button.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        button.titleLabel?.lineBreakMode = .byWordWrapping;
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(ensure), for: .touchUpInside)
        return button
    }()
    
    private lazy var rephotographButton: UIButton = {
        let button = UIButton()
        button.setTitle("重\n拍", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping;
        button.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(rephotograph), for: .touchUpInside)
        return button
    }()
    
    private lazy var doubleTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer.init(target: self,
                                              action: #selector(doubleTapAction(gesture:)))
        tap.numberOfTapsRequired = 2
        return tap
    }()
}

extension APPhotoPreview {
    
    func layoutSuvViews() {
        backgroundColor = UIColor.init(hex6: 0x676767)
        
        layoutPhotoView()
        layoutToolView()
    }
    
    func layoutPhotoView() {
        
        addSubview(photoView)
//        photoView.addSubview(scrollView)
        photoView.addSubview(imageView)
        
        photoView.snp.makeConstraints { (make) in
            let edge = UIEdgeInsets.init(top: camera_preview_top, left: camera_Padding, bottom: camera_RightViewWidth, right: camera_Padding)
            make.edges.equalToSuperview().inset(edge)
        }
        
//        scrollView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//    
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func layoutToolView() {
        
        addSubview(ensureButton)
        addSubview(rephotographButton)
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
}

extension APPhotoPreview {
    
    @objc func ensure() {
        removeFromSuperview()
        photoPreviewHandle?(true)
    }
    
    @objc func rephotograph() {
        removeFromSuperview()
        photoPreviewHandle?(false)
    }
    
    @objc func doubleTapAction(gesture: UITapGestureRecognizer) {
        
    }
}

extension APPhotoPreview: UIScrollViewDelegate {
    
}
