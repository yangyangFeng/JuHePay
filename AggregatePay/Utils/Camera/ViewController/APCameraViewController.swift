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

    let leftToolView = UIView()
    let rightToolView = UIView()
    /// 图片显示区域
    lazy var takePhotoCameraView: APTakePhotoCameraView = {
       let view = APTakePhotoCameraView.init(frame: previewRect)
       return view
    }()
    var scanCardType: TCARD_TYPE!
    var ocrCameraView: APOCRCameraView?
    
    weak var delegate: APCameraViewControllerDelegate?
    /// 切换成扫描模式
    var scanButton: UIButton = UIButton()
    
    /// 切换成拍摄模式
    var takePhotoButton: UIButton = UIButton()
    
    /// 拍摄模式下确认照片
    let ensureButton = UIButton()
    var currentCameraMode: APCameraMode?
    
    public var supportCameraMode: APSupportCameraMode = .scan {
        didSet {
            switch supportCameraMode {
            case .scan:
                takePhotoButton.isHidden = true
                ensureButton.isHidden = true
                scanButton.isHidden = true
            case .takePhoto:
                takePhotoButton.isHidden = true
                scanButton.isHidden = true
            case .all:
                break
            }
        }
    }
    
    /// 显示相片的区域
   lazy public var previewRect: CGRect = {
        let layerWidth = SCREENWIDTH - camera_Padding - camera_Padding
        let layerHeight = SCREENHEIGHT - camera_LeftViewWidth - camera_Padding - camera_RightViewWidth
        let rect = CGRect.init(x: 0, y: 0, width: layerWidth, height: layerHeight)
        return rect
    }()
    
    /// LifeCycle
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
        scanAction(takePhotoButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
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
        ensureButton.isExclusiveTouch = true
        ensureButton.addTarget(self, action: #selector(ensurePhoto), for: .touchUpInside)
        rightToolView.addSubview(ensureButton)
        
//        布局左中右三个模块
        leftToolView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(camera_LeftViewWidth)
        }
        rightToolView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(camera_RightViewWidth)
        }

//        布局左视图
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-camera_Padding)
            make.height.width.equalTo(camera_LeftViewWidth)
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
    
    
    /// 创建图片再上，文字在下的按钮
    ///
    /// - Returns: button
    func setButton(button: UIButton) {
        button.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.contentHorizontalAlignment = .center
        button.isExclusiveTouch = true
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
                view.makeToast(error.localizedDescription)
            }
        }
    }

    /// 扫描、拍摄切换
    ///
    /// - Parameter sender: 模式切换按钮
    @objc func scanAction(_ sender: UIButton) {
        if sender == scanButton {
            if currentCameraMode != .scan {
                takePhotoCameraView.removeFromSuperview()
                checkoutOCR()
                currentCameraMode = .scan
                scanButton.isSelected =  true
                takePhotoButton.isSelected = false
            }
        } else {
            if currentCameraMode != .takePhoto {
                ocrCameraView?.removeFromSuperview()
                checkoutTakePhoto()
                currentCameraMode = .takePhoto
                takePhotoButton.isSelected = true
                scanButton.isSelected = false
            }
        }
    }
    
   private func checkoutTakePhoto() {
    
        weak var weakSelf = self
        takePhotoCameraView.capturePhoto = {(image) in
            weakSelf?.preview(withImage: image){(isUse) in
                if isUse {
                    weakSelf?.delegate?.cameraViewController?(weakSelf!, didFinishPickingImage: image)
                    weakSelf?.backAction()
                }
            }
        }
        view.addSubview(takePhotoCameraView)
        takePhotoCameraView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(camera_Padding)
            make.top.equalTo(leftToolView.snp.bottom).offset(camera_Padding)
            make.right.equalToSuperview().offset(-camera_Padding)
            make.bottom.equalTo(rightToolView.snp.top)
        }
        ensureButton.isHidden = false
    }
    
   private func checkoutOCR() {
    
       weak var weakSelf = self
       ocrCameraView = APOCRCameraView.init(frame: view.frame, scanType: scanCardType)
        if scanCardType == TIDCARD2 {
            ocrCameraView?.idCardResult = {(idCard, isSuccess, message) in
                if !isSuccess {
                    weakSelf?.view.makeToast(message)
                    weakSelf?.backAction()
                } else {
                    weakSelf?.preview(withImage: idCard.image){ (isUse) in
                        if isUse {
                            weakSelf?.delegate?.ocrCameraIDCardResult?(IDCard: idCard)
                            weakSelf?.backAction()
                        }
                    }
                }
            }
        } else {
            ocrCameraView?.bankCardResult = {(bankCard, isSuccess, message) in
                if !isSuccess {
                    weakSelf?.view.makeToast(message)
                    weakSelf?.backAction()
                } else {
                    weakSelf?.preview(withImage: bankCard.bankCardImage){ (isUse) in
                        weakSelf?.delegate?.ocrCameraBankCardResult?(bankCard: bankCard)
                        weakSelf?.backAction()
                    }
                }
            }
            
       }
       view.addSubview(ocrCameraView!)
       ocrCameraView?.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
       }
       reloadLaysubViews()
   }
   private func reloadLaysubViews() {
       ensureButton.isHidden = true
       view.bringSubview(toFront: leftToolView)
       view.bringSubview(toFront: rightToolView)
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
 
    /// 确认拍摄照片
    @objc func ensurePhoto() {
        takePhotoCameraView.getTakePhoto()
    }
}
