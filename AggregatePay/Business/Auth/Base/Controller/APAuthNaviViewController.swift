//
//  APAuthNaviViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APFinishAuths = () -> Void

class APAuthNaviViewController: APBaseNavigationViewController {

    var processView: APBillSelectView!
    var finishAuths: APFinishAuths?
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        edgesForExtendedLayout = []
        
        let auths = APAuthHelper.sharedInstance.auths
        let titles = auths.map({(auth) in
            auth.name
        })
        processView = APBillSelectView.init(titleArray: titles)
        processView.canTouch = false
        processView.backgroundColor = UIColor.init(hex6: 0xf5f5f5)
        view.addSubview(processView)
        processView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            processView.setBtnIndex(index: viewControllers.count)
        }
        super.pushViewController(viewController, animated: true)
    }
}

