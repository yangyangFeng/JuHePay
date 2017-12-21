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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "推广"
        
        let shareView = APShareListView()
        shareView.delegate = self
        view.addSubview(shareView)
        shareView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        // Do any additional setup after loading the view.
    }

    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        print( "点击 \(indexPath) + \(obj)")
        let image = UIImageView()
        view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(0)
            make.height.equalTo((shareImage?.size.height)!)
            make.width.equalTo((shareImage?.size.width)!)
            make.bottom.equalTo(-20)
        }
        image.image = shareImage
        if indexPath.row == 0 {
            shared(scene: .friend)
        }
        else if indexPath.row == 1 {
            shared(scene: .circle)
        }
        else if indexPath.row == 2 {
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
