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

extension APMineViewController : APMineStaticListViewDelegate, AP_ActionProtocol {
    func tableViewDidSelectIndex(_ title: String, controller: String, level: Int) {
        print(controller)
        
        guard let vc = classFromString(classString: controller) else {
            return
        }
        vc.title = title
        
        switch level {
        case 0:
            self.navigationController?.pushViewController(vc)
        case 1:
            if !APUserInfoTool.isLogin() {
                APOutLoginTool.login()
            }
            
            if vc.isKind(of: APAuthHomeViewController.self) {
                AuthH.openAuth(isAlert: false, success: {
                    self.navigationController?.pushViewController(vc)
                }, failure: { (message) in
                    
                })
            } else {
                self.navigationController?.pushViewController(vc)
            }
            
        case 2:
            if !APUserInfoTool.isLogin() {
                APOutLoginTool.login()
            }
            AuthH.openAuth(success: {
                self.navigationController?.pushViewController(vc)
            }, failure: { (message) in
                
            })
        default:
            break
        }
    }
}


class APMineViewController: APMineBaseViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "我的"
        
        initSubviews()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    
    func initSubviews(){
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
    }
    
    func loadData(){
        guard APUserInfoTool.isLogin() else {
            self.staticListView.tableView.mj_header.endRefreshing()
            return
        }
        self.headView.model = APUserInfoResponse.mj_object(withKeyValues: APUserInfoTool.info.mj_keyValues())
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
    
    @objc func headDidAction(){
        if !APUserInfoTool.isLogin() {
            APOutLoginTool.login()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
