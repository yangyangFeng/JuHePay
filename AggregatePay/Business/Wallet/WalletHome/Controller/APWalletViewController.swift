//
//  APWalletViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 钱包首页
 */
class APWalletViewController: APBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let headerView: APWalletHeaderView = APWalletHeaderView()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let view = APBarButtonItem.ap_barButtonItem(self ,title: "账单", action: #selector(dismissGoHome))
        return view
    }()
    
    //MARK: ---- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "钱包"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        edgesForExtendedLayout =  UIRectEdge.top
        vhl_setNavBarBackgroundAlpha(0.0)
        view.theme_backgroundColor = ["#fafafa"]
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(210)
        }
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //MARK: -------------- 按钮触发
    
    @objc func dismissGoHome() {
        
    }
    
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletCell: APWalletCell = APWalletCell.cellWithTableView(tableView) as! APWalletCell
        walletCell.titleLabel.text = "钱包明细"
        walletCell.iconImageView.theme_image = ["wallet_detail_cell_icon"]
        return walletCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(APWalletDetailViewController(), animated: true)
    }

    //MARK: ---- 懒加载
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APWalletCell.self, forCellReuseIdentifier: "APWalletCell")
        return view
    }()

    
    
}
