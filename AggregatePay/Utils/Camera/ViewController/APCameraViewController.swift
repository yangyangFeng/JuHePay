//
//  APCameraViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum APSupportCameraMode {
    case scan, takePhoto, all
}

enum APCameraMode {
    case scan, takePhoto
}

protocol APCameraViewControllerDelegate {
    func cameraViewController(_ : APCameraViewController, didFinishPickingImage image: UIImage)
}
class APCameraViewController: APBaseViewController {
    
    var  isShow:Bool = false
    
    let leftViewWidth: CGFloat = 52.0
    let rightViewWidth: CGFloat = 107.0
    let padding: CGFloat = 20.0
    
    var supportCameraMode: APSupportCameraMode = .takePhoto
    var currentCameraMode: APCameraMode = .scan
    public var scanCardType: TCARD_TYPE = TIDCARD2
    
    
    /// 显示相片的区域
    public var previewRect: CGRect {
        let layerWidth = SCREENWIDTH - padding - padding
        let layerHeight = SCREENHEIGHT - leftViewWidth - padding - rightViewWidth
        let rect = CGRect.init(x: 0, y: 0, width: layerWidth, height: layerHeight)
        return rect
    }
    
    let leftToolView = UIView()
    let rightToolView = UIView()
    /// 图片显示区域
    let photoShowView = UIView()
    
    var delegate: APCameraViewControllerDelegate?
    /// 切换成扫描模式
    var scanButton: UIButton = UIButton()
    
    /// 切换成拍摄模式
    var takePhotoButton: UIButton = UIButton()
    
    /// 拍摄模式下确认照片
    let ensureButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        
        APUserAuthorization.checkCameraPermission(authorizedBlock: { (msg) in
            
        }) { (msg) in
            weakSelf?.dismiss(animated: true, completion: nil)
            weakSelf?.view.makeToast(msg)
            return
        }
        
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isShow = true
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return isShow
    }
    
}

extension APCameraViewController {
  fileprivate func layoutViews() {
        
        view.backgroundColor = UIColor.darkGray
    
        /// 相机页面左工具栏父视图
        leftToolView.backgroundColor = UIColor.init(hex6: 0x000000, alpha: 0.52)
        view.addSubview(leftToolView)
        
        /// 相机页面取消按钮
        let backButton = UIButton()
        backButton.setImage(UIImage.init(named: "camera_backBtn"), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        leftToolView.addSubview(backButton)
        
        // TODO : 后期需要判断是否支持闪光灯
        /// 闪光灯按钮
        let flashButton: UIButton?
        flashButton = UIButton()
        flashButton?.setImage(UIImage.init(named: "camera_flash_close"), for: .normal)
        flashButton?.setImage(UIImage.init(named: "camera_flash_open"), for: .selected)
        flashButton?.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        flashButton?.addTarget(self, action: #selector(flashButtonAction(_:)), for: .touchUpInside)
        leftToolView.addSubview(flashButton!)
    
        photoShowView.backgroundColor = UIColor.clear
        view.addSubview(photoShowView)
        
        /// 右工具栏
        rightToolView.backgroundColor = UIColor.clear
        view.addSubview(rightToolView)
//
//        切换成扫描
        scanButton.setTitle("扫描", for: .normal)
        scanButton.setImage(UIImage.init(named: "camera_scan_noraml"), for: .normal)
        scanButton.setImage(UIImage.init(named: "camera_scan_selected"), for: .selected)
        setButton(button: scanButton)
        scanButton.addTarget(self, action: #selector(scanAction(_:)), for: .touchUpInside)
        rightToolView.addSubview(scanButton)
        
//        切换成拍摄
        takePhotoButton.setTitle("拍摄", for: .normal)
        takePhotoButton.setImage(UIImage.init(named: "camera_shoot_noraml"), for: .normal)
        takePhotoButton.setImage(UIImage.init(named: "camera_shoot_selected"), for: .selected)
        setButton(button: takePhotoButton)
        takePhotoButton.addTarget(self, action: #selector(scanAction(_:)), for: .touchUpInside)
        rightToolView.addSubview(takePhotoButton)

//       拍摄状态下确认照片
        ensureButton.setImage(UIImage.init(named: "camera_ensureBtn"), for: .normal)
        ensureButton.addTarget(self, action: #selector(ensurePhoto), for: .touchUpInside)
        rightToolView.addSubview(ensureButton)
        
//        布局左中右三个模块
        leftToolView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(leftViewWidth)
        }
        rightToolView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(rightViewWidth)
        }
        photoShowView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(padding)
            make.top.equalTo(leftToolView.snp.bottom).offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.bottom.equalTo(rightToolView.snp.top)
        }
//        布局左视图
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-padding)
            make.height.width.equalTo(leftViewWidth)
        }
        flashButton?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(backButton)
        })
//        布局中间视图
        
        
//        布局右视图
        scanButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-padding)
            make.width.equalTo(leftViewWidth)
            make.height.equalTo(leftViewWidth)
        }
        takePhotoButton.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(scanButton)
            make.right.equalTo(scanButton.snp.left).offset(-10)
        }
        ensureButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(scanButton)
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.right.equalTo(takePhotoButton.snp.left).offset(-padding)
        }
    }
    
    
    /// 创建图片再上，文字在下的按钮
    ///
    /// - Returns: button
    func setButton(button: UIButton) {
        button.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.contentHorizontalAlignment = .center
        button.titleEdgeInsets = UIEdgeInsetsMake(((button.imageView?.image?.size.height)! + 15.0), -((button.imageView?.image?.size.width)!), 0.0, 0.0)
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -((button.titleLabel?.requiredWidth)!))
    }
        
   /// 当前页面退出
   @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    /// 控制闪光灯开关
    ///
    /// - Parameter sender: 控制闪光灯开关按钮
    @objc func flashButtonAction(_ sender: UIButton) {
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                try captureDevice.lockForConfiguration()
                if (captureDevice.hasFlash) {
                    if(currentCameraMode == .scan) {
                        captureDevice.torchMode = captureDevice.torchMode == .on ? .off : .on
                    } else {
                        captureDevice.flashMode = captureDevice.flashMode != .on ? .on : .off
                    }
                    sender.isSelected = !sender.isSelected
                } else {
                    view.makeToast("设备不支持闪光灯")
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }

    /// 扫描、拍摄切换
    ///
    /// - Parameter sender: 模式切换按钮
    @objc func scanAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    /// 确认拍摄照片
    @objc func ensurePhoto() {
    
    }
}
