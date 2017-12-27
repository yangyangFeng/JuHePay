//
//  APTakePhotoCameraViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion
typealias APCapturePhotoBlock = (UIImage) -> Void
class APTakePhotoCameraView: APBaseCameraView {
    
    /// 执行输入设备和输出设备之间的数据传递
    public var session: AVCaptureSession!
    
    /// 输入设备
    fileprivate var deviceInput: AVCaptureDeviceInput!
    
    /// 输入照片流
    fileprivate var imageOutput: AVCaptureStillImageOutput!
    
    /// 预览图层
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer!
    
    /// 管理者对象
    fileprivate var motionManger: CMMotionManager = CMMotionManager()
    
    
    public var capturePhoto: APCapturePhotoBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCaptureSession()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        session.stopRunning()
        if (motionManger.isDeviceMotionActive) {
            motionManger.stopDeviceMotionUpdates()
        }
    }
    
    fileprivate func setUpCaptureSession() {
        
        session = AVCaptureSession()
        let captureDevice = AVCaptureDevice.default(for: .video)
        do {
            try captureDevice?.lockForConfiguration()
        } catch  {
            return
        }
//        captureDevice?.flashMode = .auto
        captureDevice?.unlockForConfiguration()
        
        do {
            try deviceInput = AVCaptureDeviceInput(device: captureDevice!)
        } catch  {
            return
        }
        
        imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = [AVVideoCodecJPEG : AVVideoCodecKey]
        
        session.canAddInput(deviceInput) ? session.addInput(deviceInput) : ()
        session.canAddOutput(imageOutput) ? session.addOutput(imageOutput) : ()
        
        previewLayer = AVCaptureVideoPreviewLayer.init(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = self.frame
        layer.addSublayer(previewLayer)
        
        guard let previewLayerConnection = previewLayer.connection else {
            makeToast("相机初始化失败")
            return
        }
        previewLayerConnection.videoOrientation = .portrait
        previewLayerConnection.videoScaleAndCropFactor = 1
        session.startRunning()
    }
    
    fileprivate func avOrientationForDeviceOrientation(deviceOrientation: UIDeviceOrientation) -> AVCaptureVideoOrientation? {
        if (deviceOrientation == .landscapeLeft) {
            return .landscapeRight
        } else if (deviceOrientation == .landscapeRight){
            return .landscapeLeft
        } else {
            return nil
        }
    }
    
    public func getTakePhoto() {
        guard let stillImageConnection = imageOutput.connection(with: .video) else {
            makeToast("相机初始化失败")
            return
        }
        let curDeviceOrientation = UIDevice.current.orientation
        if let avCaptureOrienttation = avOrientationForDeviceOrientation(deviceOrientation: curDeviceOrientation) {
            stillImageConnection.videoOrientation = avCaptureOrienttation
            stillImageConnection.videoScaleAndCropFactor = 1
        }
        if stillImageConnection.isVideoStabilizationSupported {
            stillImageConnection.preferredVideoStabilizationMode = .auto
        }
        weak var weakSelf = self
        imageOutput.captureStillImageAsynchronously(from: stillImageConnection) {[unowned self] (imageDataSampleBuffer, error) in
            if let _error = error {
                weakSelf?.makeToast(_error.localizedDescription)
                return
            }
            guard let _ = imageDataSampleBuffer else {
                return
            }
            if let jpegData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!) {
                if let tempImage = UIImage(data: jpegData, scale: 1) {
                    if let tempCgImage = tempImage.cgImage {
                        let image = UIImage(cgImage: tempCgImage, scale: 0.1, orientation: UIImageOrientation.up)
                        weakSelf?.capturePhoto?(image)
                    }
                }
            }
        }
    }
}
