//
//  APAuthHomeViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthHomeViewController: APBaseViewController {
    
    fileprivate var auths = APAuthHelper.sharedInstance.auths
    
    let tableView : UITableView = UITableView(frame: CGRect.zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "身份认证"
    
        ap_setStatusBarStyle(.lightContent)
        
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
          loadAuthInfo()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        APAuthHelper.clearAuthInfo()
//    }
    
    deinit {
        APAuthHelper.clearAuthInfo()
        print( String(describing: self.classForCoder) + "已释放")
    }
    
    
    // MARK: -- Data
    func loadAuthInfo() {
        
        view.AP_loadingBegin()
        APAuthHttpTool.getUserAuthInfo(params: APBaseRequest(), success: { (authInfo) in
            
            self.view.AP_loadingEnd()
            self.tableView.reloadData()
            
        }) {(error) in
            self.view.AP_loadingEnd()
            self.view.makeToast(error.message)
        }
    }
}

extension APAuthHomeViewController {
    //MARK: -- UI
  private func layoutViews() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.init(hex6: 0xf0f0f0)
        
        // MARK:这样设置可以让tableView分割线顶头
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .singleLine
        tableView.register(APAuthHomeCell.self, forCellReuseIdentifier: NSStringFromClass(APAuthHomeCell.self))
        tableView.layer.borderColor = UIColor.init(hex6: 0xf0f0f0).cgColor
        tableView.layer.borderWidth = 1
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 56
        tableView.mj_header = APRefreshHeader(refreshingBlock: {[weak self] in
             self?.loadAuthInfo()
        })
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: -- UITableViewDelegate & UITableViewDataSource

extension APAuthHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = APAuthHomeCell.cellWithTableView(tableView)
        cell?.auth = auths[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        
        switch APAuthHelper.sharedInstance.realNameAuthState {
            
        case .None, .Failure:
            let authNavi = APAuthNaviViewController.init(rootViewController: APRealNameAuthViewController())
            self.navigationController?.present(authNavi, animated: true, completion: nil)
            authNavi.finishAuths = {
                authNavi.dismiss(animated: true, completion: nil)
            }
            
        case .Other:
            view.makeToast("暂时无法获取审核信息")
            
        default:
            let auth = auths[indexPath.row]
            var baseAuthVC = APAuthBaseViewController()
            
            switch auth.type {
            case .realName:
                baseAuthVC = APRealNameAuthViewController()
            case .settleCard:
                baseAuthVC = APSettlementCardAuthViewController()
            case .Security:
                baseAuthVC = APSecurityAuthViewController()
            }
            
            baseAuthVC.auth = auth
            navigationController?.pushViewController(baseAuthVC, animated: true)
        }
    }
}
