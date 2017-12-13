//
//  APAuthHomeViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHomeViewController: APBaseViewController {
    
    var dataSource:Array<Any>?
    
    lazy var authHomeView: APAuthHomeView = {
        let view = APAuthHomeView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = loadAuthStatus()
        setUpUI()
    }

    func setUpUI() {
        
        view.addSubview(authHomeView)
        authHomeView.snp.makeConstraints { (make) in
           make.top.equalTo(-vhl_navigationBarAndStatusBarHeight());
           make.left.right.bottom.equalTo(authHomeView.superview!)
        }
        authHomeView.dataSource = dataSource!
        authHomeView.tableView .reloadData()
    }
    
    func loadAuthStatus() -> Array<Any> {
        let titles = ["实名认证", "结算卡认证", "安全认证"]
        var dataSource: Array<Any> = []
        
        for title in titles {
            let model = APAuthHomeModel()
            model.authName = title
            model.authStatus = 1
            dataSource.append(model)
        }
        return dataSource
    }

}
