//
//  APCameraManagerController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/24.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCameraManagerController: APBaseViewController {

    fileprivate var  isShow:Bool = false
    public var supportCameraMode: APSupportCameraMode = .takePhoto
    public var scanCardType: TCARD_TYPE = TIDCARD2
    public var cameraDelegate: APCameraViewControllerDelegate?
    fileprivate var willShowVC: APCameraViewController!
    
    
    var ocrViewController: APOCRCameraViewController {
        let vc = APOCRCameraViewController()
        return vc
    }
    var takePhotoViewController: APTakePhotoCameraViewController {
        let vc = APTakePhotoCameraViewController()
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSupViewController()
        addNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isShow = true
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return isShow
    }
    
    fileprivate func addSupViewController() {
        
        switch supportCameraMode {
        case .scan:
            willShowVC = ocrViewController
        case .takePhoto:
            willShowVC = takePhotoViewController
        default:
            willShowVC = ocrViewController
        }
        addSubView(withController: willShowVC)
    }
    
    fileprivate func addNotification() {
        let name = NSNotification.Name("SwichCamera")
        NotificationCenter.default.addObserver(self, selector: #selector(swichCamera(noti:)), name: name, object: nil)
    }
    @objc func swichCamera(noti: NSNotification) {
        let object = noti.object
        let willShowVC: APCameraViewController!
        
        if object as! APCameraMode == .scan {
            willShowVC = ocrViewController
        } else {
            willShowVC = takePhotoViewController
        }
        addSubView(withController: willShowVC)
    }
    
    func addSubView(withController willShowVC: APCameraViewController) {
        
        if childViewControllers.count > 0 {
            for vc in childViewControllers {
                vc.removeFromParentViewController()
                vc.view.removeFromSuperview()
            }
        }
        willShowVC.willMove(toParentViewController: self)
        addChildViewController(willShowVC)
        view.addSubview(willShowVC.view)
        willShowVC.view.frame = view.frame
        willShowVC.didMove(toParentViewController: self)
        
        for vc in childViewControllers {
            let cameraVC = vc as! APCameraViewController
            cameraVC.delegate = cameraDelegate
            cameraVC.scanCardType = scanCardType
            cameraVC.supportCameraMode = supportCameraMode
        }
    }
}
