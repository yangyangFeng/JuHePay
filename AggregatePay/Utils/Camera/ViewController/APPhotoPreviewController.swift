//
//  APPhotoPreviewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
typealias APPhotoPreviewHandle = (_ isEnsure: Bool) -> Void
class APPhotoPreviewController: APBaseViewController {

    public var photoPreviewHandle: APPhotoPreviewHandle?
    public var photo: UIImage? {
        didSet{
            let leftImage = UIImage.init(cgImage: (photo?.cgImage!)!, scale: (photo?.scale)!, orientation: .right)
            imageView.image = leftImage
        }
    }
    fileprivate let imageView: UIImageView = UIImageView()
    fileprivate var fromViewController: APBaseViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        layoutSuvViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vhl_setNavBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vhl_setNavBarHidden(false)
    }

    public func show(fromController viewController: APBaseViewController, image: UIImage) {
        photo = image
        fromViewController = viewController
        UIApplication.shared.isStatusBarHidden = true
        viewController.addChildViewController(self)
        viewController.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        didMove(toParentViewController: viewController)
    }
    
    public func dismiss() {
        UIApplication.shared.isStatusBarHidden = false
        for vc in fromViewController.childViewControllers {
            vc.willMove(toParentViewController: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
    }
}

extension APPhotoPreviewController {
    func layoutSuvViews() {
        view.backgroundColor = UIColor.darkGray
        
        let photoView = UIView()
        photoView.backgroundColor = UIColor.init(hex6: 0xEBEBEB)
        view.addSubview(photoView)
        
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
        view.addSubview(ensureButton)
        
        let rephotographButton = UIButton()
        rephotographButton.setTitle("重\n拍", for: .normal)
        rephotographButton.titleLabel?.lineBreakMode = .byWordWrapping;
        rephotographButton.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi/2))
        rephotographButton.setTitleColor(UIColor.white, for: .normal)
        rephotographButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        rephotographButton.addTarget(self, action: #selector(rephotograph), for: .touchUpInside)
        view.addSubview(rephotographButton)
        
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
        dismiss()
        photoPreviewHandle?(true)
    }
    
    @objc func rephotograph() {
        dismiss()
        photoPreviewHandle?(false)
    }
}
