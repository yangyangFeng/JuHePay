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

 @objc protocol APCameraViewControllerDelegate {
    
  @objc optional func cameraViewController(_ : APCameraViewController, didFinishPickingImage image: UIImage)
  @objc optional  func ocrCameraBankCardResult(bankCard result: APOCRBankCard)
  @objc optional func ocrCameraIDCardResult(IDCard result: APOCRIDCard)
}
class APCameraViewController: APBaseViewController {

   public var scanCardType: TCARD_TYPE!
   public weak var delegate: APCameraViewControllerDelegate?
    
   private var currentCameraMode: APCameraMode? {
        didSet {
            if currentCameraMode == .scan {
                
                ensureButton.isHidden = true
                scanButton.isSelected =  true
                takePhotoButton.isSelected = false
            } else {
                ensureButton.isHidden = false
                takePhotoButton.isSelected = true
                scanButton.isSelected = false
            }
        }
    }
    
    public var supportCameraMode: APSupportCameraMode = .scan {
        didSet {
            switch supportCameraMode {
            case .scan:
                currentCameraMode = .scan
                takePhotoButton.isHidden = true
                ensureButton.isHidden = true
                scanButton.isHidden = true
                
            case .takePhoto:
                currentCameraMode = .takePhoto
                takePhotoButton.isHidden = true
                scanButton.isHidden = true
                
            case .all:
                currentCameraMode = .scan
            }
        }
    }
    
    // ---------------------------------------- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCameraPermission()
        setUpUI()
//        flashButtonAction()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
        
//        switch supportCameraMode {
//        case .takePhoto:
//            takePhotoCameraView.session.startRunning()
//        default:
//            ocrCameraView.captureManager.session.startRunning()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false

        switch supportCameraMode {
        case .takePhoto:
            takePhotoCameraView.session.stopRunning()
        case .scan:
            ocrCameraView.captureManager.session.stopRunning()
            ocrCameraView.captureManager = nil
        default:
            takePhotoCameraView.session.stopRunning()
            ocrCameraView.captureManager.session.stopRunning()
            ocrCameraView.captureManager = nil
        }
    }
    
    //------------------------------------- 获取相机权限
    
    private func checkCameraPermission() {
        
        APUserAuthorization.checkCameraPermission(authorizedBlock: { (msg) in
           
        }) {[weak self] (msg) in
            self?.dismiss(animated: true, completion: nil)
            self?.view.makeToast(msg)
        }
    }
    
    //------------------------------------- 子控件初始化
    
    /// 相机左侧工具栏
    private lazy var leftToolView: UIView = {
        let toolView = UIView()
        toolView.backgroundColor = UIColor.init(hex6: 0x000000, alpha: 0.52)
        return toolView
    }()
    
    /// 左侧工具栏取消按钮
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "camera_backBtn"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    /// 左侧工具栏闪光灯按钮
    private lazy var flashButton: UIButton = {
        let button = UIButton() // camera_flash_auto
        
        if currentCameraMode == .takePhoto {
            button.setImage(UIImage.init(named: "camera_flash_auto"), for: .normal)
        } else {
            button.setImage(UIImage.init(named: "camera_flash_close"), for: .normal)
        }
        button.setImage(UIImage.init(named: "camera_flash_open"), for: .selected)
        button.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        button.addTarget(self, action: #selector(flashButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// 相机右侧工具栏
    private lazy var rightToolView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /// 切换到扫描按钮
    private lazy var scanButton: UIButton = {
        let button = UIButton()
        button.setTitle("扫描", for: .normal)
        button.setImage(UIImage.init(named: "camera_scan_noraml"), for: .normal)
        button.setImage(UIImage.init(named: "camera_scan_selected"), for: .selected)
        button.setupButtonStyle()
        button.addTarget(self, action: #selector(scanAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 切换到拍摄照片按钮
    private lazy var takePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("拍摄", for: .normal)
        button.setImage(UIImage.init(named: "camera_shoot_noraml"), for: .normal)
        button.setImage(UIImage.init(named: "camera_shoot_selected"), for: .selected)
        button.setupButtonStyle()
        button.addTarget(self, action: #selector(scanAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 拍摄状态下确定照片按钮
    private lazy var ensureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "camera_ensureBtn"), for: .normal)
        button.isExclusiveTouch = true
        button.addTarget(self, action: #selector(ensurePhoto), for: .touchUpInside)
        return button
    }()
    
    /// 拍摄照片的区域
    lazy public var previewRect: CGRect = {
        let layerWidth = SCREENWIDTH - camera_Padding - camera_Padding
        let layerHeight = SCREENHEIGHT - camera_LeftViewWidth - camera_Padding - camera_RightViewWidth
        let rect = CGRect.init(x: 0, y: 0, width: layerWidth, height: layerHeight)
        return rect
    }()
    
    /// 拍摄照片View
    private lazy var takePhotoCameraView: APTakePhotoCameraView = {
        let view = APTakePhotoCameraView.init(frame: previewRect)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    /// OCR扫描view
    private lazy var ocrCameraView: APOCRCameraView = {
        guard let scanType = scanCardType else {
            fatalError("scanCardType must set value")
        }
        let view = APOCRCameraView.init(frame: self.view.frame, scanType: scanCardType)
        view.backgroundColor = self.view.backgroundColor
        return view
    }()
}

// MARK: - 布局

extension APCameraViewController {
    
    private func setUpUI() {
        layoutSubViews()
        layoutLeftToolView()
        layoutRightToolView()
        layoutCameraView()
    }
    
    private func layoutSubViews() {
        //设置背景颜色
        view.backgroundColor = UIColor.init(hex6: 0x676767)
        
        view.addSubview(leftToolView)
        view.addSubview(rightToolView)
        
        leftToolView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(camera_LeftViewWidth)
        }
        rightToolView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(camera_RightViewWidth)
        }
    }
    
    private func layoutLeftToolView() {
        
        leftToolView.addSubview(backButton)
        leftToolView.addSubview(flashButton)
        
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-camera_Padding)
            make.height.width.equalTo(camera_LeftViewWidth)
        }
        flashButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(backButton)
        })
    }
    
    private func layoutCameraView() {
        
        switch supportCameraMode {
        case .scan:
            layoutOCRCameraView()
        case .takePhoto:
            layoutTakePhotoCameraView()
        case .all:
            layoutTakePhotoCameraView()
            layoutOCRCameraView()
            takePhotoCameraView.isHidden = true
        }
    }
    
    private func layoutTakePhotoCameraView() {
        
        view.insertSubview(takePhotoCameraView, belowSubview: leftToolView)
        takePhotoCameraView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(camera_Padding)
            make.top.equalTo(leftToolView.snp.bottom).offset(camera_Padding)
            make.right.equalToSuperview().offset(-camera_Padding)
            make.bottom.equalTo(rightToolView.snp.top)
        }
    }
    
    private func layoutOCRCameraView() {
        
        view.insertSubview(ocrCameraView, belowSubview: leftToolView)
        ocrCameraView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func layoutRightToolView() {
        
        rightToolView.addSubview(scanButton)
        rightToolView.addSubview(takePhotoButton)
        rightToolView.addSubview(ensureButton)
        
        scanButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-camera_Padding)
            make.width.equalTo(camera_LeftViewWidth)
            make.height.equalTo(camera_LeftViewWidth)
        }
        takePhotoButton.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(scanButton)
            make.right.equalTo(scanButton.snp.left).offset(-10)
        }
        ensureButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(scanButton)
            make.width.equalTo(camera_EnsureSize)
            make.height.equalTo(camera_EnsureSize)
//            make.right.equalTo(takePhotoButton.snp.left).offset(-camera_Padding)
            make.centerX.equalToSuperview()
        }
    }
}


// MARK: - Event

extension APCameraViewController {
    /// 当前页面退出
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 确认拍摄照片
    @objc func ensurePhoto() {
        takePhotoCameraView.getTakePhoto()
    }
    
    /// 控制闪光灯开关
    ///
    /// - Parameter sender: 控制闪光灯开关按钮
    @objc func flashButtonAction() {
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                try captureDevice.lockForConfiguration()
                if (captureDevice.hasFlash) {
                    
                    if(currentCameraMode == .scan) {
                        setOCRCameraFlash(captureDevice: captureDevice)
                    } else {
                        setTakePhotoCameraFlash(captureDevice: captureDevice)
                    }
                } else {
                    view.makeToast("设备不支持闪光灯")
                }
                
            } catch (let error) {
                view.makeToast(error.localizedDescription)
            }
        }
    }
    
    private func setOCRCameraFlash(captureDevice: AVCaptureDevice) {
        captureDevice.torchMode = captureDevice.torchMode == .on ? .off : .on
        flashButton.isSelected = !flashButton.isSelected
    }
    
    private func setTakePhotoCameraFlash(captureDevice: AVCaptureDevice) {
        guard captureDevice.isFlashModeSupported(.auto) else {
            captureDevice.flashMode = captureDevice.flashMode == .on ? .off : .on
            flashButton.isSelected = !flashButton.isSelected
            return
        }
        
//        let imageName: String!
//        switch captureDevice.flashMode {
//        case .auto:
//            captureDevice.flashMode = .on
//            imageName = "camera_flash_open"
//        case .on:
//            captureDevice.flashMode = .off
//            imageName = "camera_flash_close"
//        case .off:
//            captureDevice.flashMode = .auto
//            imageName = "camera_flash_auto"
//        }
//       flashButton.setImage(UIImage.init(named: imageName), for: .normal)
    }
    
    /// 扫描、拍摄切换
    ///
    /// - Parameter sender: 模式切换按钮
    @objc func scanAction(_ sender: UIButton) {
        if sender == scanButton {
            if currentCameraMode != .scan {
                checkoutOCR()
                bringView(toFront: ocrCameraView, above: takePhotoCameraView)
                ocrCameraView.captureManager.session.startRunning()
                takePhotoCameraView.session.stopRunning()
                currentCameraMode = .scan
            }
        } else {
            if currentCameraMode != .takePhoto {
                checkoutTakePhoto()
                bringView(toFront: takePhotoCameraView, above: ocrCameraView)
                ocrCameraView.captureManager.session.stopRunning()
                takePhotoCameraView.session.startRunning()
                currentCameraMode = .takePhoto
                
            }
        }
    }
    
    private func bringView(toFront: UIView, above: UIView) {
        let frontIndex = view.subviews.index(of: toFront)
        let aboveIndex = view.subviews.index(of: above)
        view.exchangeSubview(at: frontIndex!, withSubviewAt: aboveIndex!)
        toFront.isHidden = false
        above.isHidden = true
    }
    
    private func checkoutTakePhoto() {
        
        takePhotoCameraView.capturePhoto = {[weak self] (image) in
            self?.preview(withImage: image){(isUse) in
                if isUse {
                    self?.delegate?.cameraViewController?(self!, didFinishPickingImage: image)
                    self?.backAction()
                }
            }
        }
    }
    
    private func checkoutOCR() {
        
        if scanCardType == TIDCARD2 {
            ocrCameraView.idCardResult = {[weak self] (idCard, isSuccess, message) in
                if !isSuccess {
                    self?.view.makeToast(message)
                    self?.backAction()
                } else {
                    self?.preview(withImage: idCard.image){ (isUse) in
                        if isUse {
                            self?.delegate?.ocrCameraIDCardResult?(IDCard: idCard)
                            self?.backAction()
                        }
                    }
                }
            }
        } else {
            ocrCameraView.bankCardResult = {[weak self] (bankCard, isSuccess, message) in
                if !isSuccess {
                    self?.view.makeToast(message)
                    self?.backAction()
                } else {
                    self?.preview(withImage: bankCard.bankCardImage){ (isUse) in
                        self?.delegate?.ocrCameraBankCardResult?(bankCard: bankCard)
                        self?.backAction()
                    }
                }
            }
        }
    }
    
    private func preview(withImage: UIImage?, handle: ((_ isEnsure: Bool) -> Void)?) {
        if let image = withImage {
            
            let previewManager = APPhotoPreviewManager()
            previewManager.show(fromController: self, image: image)
            previewManager.photoPreview.photoPreviewHandle = {(isUse) in
                if isUse {
                    handle?(isUse)
                }
            }
        }
    }
}


// MARK: - button 扩展

extension UIButton {
    
    /// 创建图片再上，文字在下的按钮
    ///
    /// - Returns: button
    func setupButtonStyle() {
        transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        titleLabel?.font = UIFont.systemFont(ofSize: 10)
        contentHorizontalAlignment = .center
        isExclusiveTouch = true
        titleEdgeInsets = UIEdgeInsetsMake(((imageView?.image?.size.height)! + 15.0), -((imageView?.image?.size.width)!), 0.0, 0.0)
        imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -((titleLabel?.requiredWidth)!))
    }
}
