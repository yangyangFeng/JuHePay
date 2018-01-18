//
//  APSystemBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import KVOController

class APSystemBaseViewController: APBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        vhl_setNavBackgroundColor(UIColor.white)
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
    }
    
    override func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "Navigation_Back")
        return image!.withRenderingMode(.alwaysOriginal)
    }
    
    func createContainerView() {
        
        view.insertSubview(scrollView, at: 0)
        scrollView.addSubview(containerView)
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.clipsToBounds = false
        scrollView.backgroundColor = UIColor.clear
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
}
