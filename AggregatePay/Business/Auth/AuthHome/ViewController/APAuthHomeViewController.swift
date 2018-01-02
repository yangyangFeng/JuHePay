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
        
        loadAuthInfo()
        
        ap_setStatusBarStyle(.lightContent)
        
        layoutViews()
    }
    
    // MARK: -- Data
    func loadAuthInfo() {
        APAuthHttpTool.getUserAuthInfo(params: APBaseRequest(), success: { (authInfo) in
            
            self.tableView.reloadData()
            
        }) { [weak self] (error) in
            self?.view.makeToast(error.message)
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
        
        if APAuthHelper.sharedInstance.isFirstAuth {
            
            let authNavi = APAuthNaviViewController.init(rootViewController: APRealNameAuthViewController())
            self.navigationController?.present(authNavi, animated: true, completion: nil)
            authNavi.finishAuths = {
                authNavi.dismiss(animated: true, completion: nil)
            }
        } else {
            let auth = auths[indexPath.row]
            
            
            switch auth.type {
            case .realName:
                navigationController?.pushViewController(APRealNameAuthViewController(), animated: true)
            case .settleCard:
                navigationController?.pushViewController(APSettlementCardAuthViewController(), animated: true)
            case .Security:
                navigationController?.pushViewController(APSecurityAuthViewController(), animated: true)
            }
        }
    }
}
