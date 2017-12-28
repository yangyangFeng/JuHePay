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




class APMineViewController: APMineBaseViewController, APMineStaticListViewDelegate{
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
        let view = APMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 208-64))
        return view
    }()
    
    lazy var staticListView: APMineStaticListView = {
        let view = APMineStaticListView()
        weak var weakSelf = self
        view.tableView.mj_header = APRefreshHeader(refreshingBlock: {
            self.loadData()
        })
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage.init(named: "Mine_head_bg")
        self.vhl_setNavBarBackgroundImage(image?.cropped(to: 64/208))
        
        self.ap_setStatusBarStyle(.lightContent)

        view.backgroundColor = UIColor.white
        
        title = "我的"

//        view.addSubview(headView)
        view.addSubview(staticListView)
//        headView.snp.makeConstraints { (make) in
//            make.top.equalTo(0);
//            make.left.right.equalTo(0)
//            make.height.equalTo(208-64)
//        }
        staticListView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.bottom.equalTo(0)
        }
        staticListView.tableView.tableHeaderView = headView
        // Do any additional setup after loading the view.
        
        loadData()
    }

    func loadData(){
        let param = APUserInfoRequest()
        param.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        APMineHttpTool.getUserInfo(param, success: { (res) in
            self.headView.model = res as? APUserInfoResponse
            self.staticListView.tableView.mj_header.endRefreshing()
            //MARK: 同步用户信息
            APUserInfoTool.info = APUserInfoTool.mj_object(withKeyValues: res.mj_keyValues())
            
        }) { (error) in
            self.staticListView.tableView.mj_header.endRefreshing()
        }
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
