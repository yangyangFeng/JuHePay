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
        // Do any additional setup after loading the view.
    }

    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        if indexPath.row == 0 {
            shared(scene: .friend)
        }
        else if indexPath.row == 1 {
            shared(scene: .circle)
        }
        else if indexPath.row == 2 {
            guard !isSaveImage else{
                self.view.makeToast("已保存")
                return
            }
            let action: Selector = #selector(image(image:didFinishSavingWithError:contextInfo:))
            UIImageWriteToSavedPhotosAlbum(shareImage!, self, action, nil)
        }    
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            self.view.makeToast("保存失败")
        }
        else {
            self.view.makeToast("保存成功")
            isSaveImage = true
        }
    }
    
    func shared(scene: APSharedScene) {
        APSharedTools.shared(image: shareImage!, scene: scene, success: {
            self.view.makeToast("分享成功")
        }) { (errorMsg) in
            print(errorMsg)
        }
    }
    
}
