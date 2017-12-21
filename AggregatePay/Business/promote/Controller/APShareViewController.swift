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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
