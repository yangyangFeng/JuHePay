//
//  APUserAuthorization.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import Photos

typealias OperationBlock = (_ message: String) -> Void
class APUserAuthorization: NSObject {

    /// 获取相机权限
    ///
    /// - Returns: 有无权限
    public static func checkCameraPermission(authorizedBlock: @escaping OperationBlock, deniedBlock: @escaping OperationBlock) {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authorizationStatus {
        case .notDetermined:  //用户尚未做出选择
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                checkCameraPermission(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
            })

        case .authorized:  //已授权
            authorizedBlock("用户已授权")
        case .denied:  //用户拒绝
            deniedBlock("用户拒绝访问相机")
        case .restricted:  //家长控制
            deniedBlock("家长控制")
        }
    }
}

