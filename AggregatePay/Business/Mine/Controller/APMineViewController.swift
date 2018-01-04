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
import Alamofire



class APMineViewController: APMineBaseViewController, APMineStaticListViewDelegate, AP_ActionProtocol{
    func tableViewDidSelectIndex(_ title: String, controller: String, level: Int) {
        print(controller)
        guard APAccessControler.checkAccessControl(level) else {
            ap_userIdentityStatus(closure: {
                
            })
            return
        }
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

    lazy var headView: APMineHeaderView = {
        let view = APMineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 208-64))
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(headDidAction), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(0)
        }
        return view
    }()
    
    lazy var staticListView: APMineStaticListView = {
        let view = APMineStaticListView()
        weak var weakSelf = self
        view.tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.loadData()
        })
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "我的"
        
        view.backgroundColor = UIColor.white
        self.ap_setStatusBarStyle(.lightContent)
        
        let image = UIImage.init(named: "Mine_head_bg")
        self.vhl_setNavBarBackgroundImage(image?.cropped(to: 64/208))
        
        view.addSubview(staticListView)
        staticListView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.bottom.equalTo(0)
        }
        staticListView.tableView.tableHeaderView = headView
        // Do any additional setup after loading the view.
        
        loadData()
    }

    func loadData(){
        guard APUserInfoTool.isLogin() else {
            self.staticListView.tableView.mj_header.endRefreshing()
            return
        }
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
    
    @objc func headDidAction(){
        guard APAccessControler.checkAccessControl(1) else {
            ap_userIdentityStatus(closure: {
                
            })
            return
        }
        let authHomeController = APAuthHomeViewController()
        navigationController?.pushViewController(authHomeController)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
