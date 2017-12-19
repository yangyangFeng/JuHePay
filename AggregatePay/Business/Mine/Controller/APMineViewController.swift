//
//  APMineViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import SnapKit
//SnapKit




class APMineViewController: APBaseViewController, APMineStaticListViewDelegate{
    func tableViewDidSelectIndex(_ title: String, controller: String) {
        print(controller)
        // -1.动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let controllerClass : AnyClass? = NSClassFromString(ns + "." + controller)
        guard let controllerType = controllerClass as? UIViewController.Type else {
            print("类型转换失败")
            return
        }
        let nextC = controllerType.init()
        nextC.title = title
        
        navigationController?.pushViewController(nextC)
    }
    

    lazy var btn: UIButton = {
        let temp = UIButton(type: UIButtonType.system)
        temp.setTitle("点击", for: UIControlState.normal)
        temp.addTarget(self, action: #selector(action), for: UIControlEvents.touchUpInside)
        temp.frame = CGRect(x: 130, y: 100, width: 100, height: 100)
        return temp
    }()
    
    lazy var headView: APMineHeaderView = {
        let view = APMineHeaderView()
        return view
    }()
    
    lazy var staticListView: APMineStaticListView = {
        let view = APMineStaticListView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.hidesBottomBarWhenPushed = false
        
        self.vhl_setNavBarBackgroundAlpha(0.0)
        
        self.ap_setStatusBarStyle(.lightContent)
//        self.ap_setNavigationBarHidden(true)
        
//        ThemeManager.setTheme(plistName: "APTheme_Normal", path: .mainBundle)
        
        view.backgroundColor = UIColor.white
        
        title = "我的"

        view.addSubview(headView)
        view.addSubview(staticListView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(-64);
            make.left.right.equalTo(0)
            make.height.equalTo(208)
        }
        staticListView.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
        }
        // Do any additional setup after loading the view.
        
        
    }

    @objc func action()
    {        
        self.navigationController?.pushViewController(APServiceViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
