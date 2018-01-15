//
//  APShareViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APShareViewController: APBaseViewController,AP_TableViewDidSelectProtocol {

    public var shareImage : UIImage?
    
    private var isSaveImage : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "推广"
        
        ap_setStatusBarStyle(.lightContent)
        
        let shareView = APShareListView()
        shareView.delegate = self
        view.addSubview(shareView)
        shareView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        if indexPath.row == 0 {
            shared(scene: 0)
        }
        else if indexPath.row == 1 {
            shared(scene: 1)
        }
        else if indexPath.row == 2 {
            saveImage(image: shareImage!)
        }
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        view.AP_loadingEnd()
        if didFinishSavingWithError != nil {
            self.view.makeToast("保存失败")
        }
        else {
            self.view.makeToast("保存成功")
            isSaveImage = true
        }
    }
    
    func shared(scene: Int) {
        APSharedUtil.ap_shared(with: shareImage!, atScens: Int32(scene), resultBlock: { (message) in
            self.view.makeToast(message)
        })
    }
    
   private func saveImage(image: UIImage) {
        APUserAuthorization.checkoutPhotoLibraryPermission(authorizedBlock: { (message) in
            
            guard !(self.isSaveImage) else{
                self.view.makeToast("已保存")
                return
            }
            self.view.AP_loadingBegin("正在保存，请稍后")
            let action: Selector = #selector(self.image(image:didFinishSavingWithError:contextInfo:))
            UIImageWriteToSavedPhotosAlbum(image, self, action, nil)
            
        }) {[weak self] (message) in
            self?.openAppSetting()
        }
    }
    
}

extension APShareViewController {
    func openAppSetting() {
        let alertController = APAlertManager.alertController(param: { (param) in
            
            param.apMessage = "开启相册才能保存照片"
            param.apConfirmTitle = "去开启"
            param.apCanceTitle = "取消"
            
        }, confirm: { (action) in
            
            let settingUrl = URL(string: UIApplicationOpenSettingsURLString)!
            
            if #available(iOS 10, *) {
                UIApplication.shared.open(settingUrl, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(settingUrl)
            }
            
        }, cancel: { (action) in
            // 取消去app的设置页面
            
        })
        present(alertController, animated: true, completion: nil)
    }
}
