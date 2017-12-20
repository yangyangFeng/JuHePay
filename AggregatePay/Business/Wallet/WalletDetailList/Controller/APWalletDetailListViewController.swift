//
//  APWalletDetailViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 钱包明细列表
 */
class APWalletDetailViewController: APBaseViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APWalletDetailListCell.self, forCellReuseIdentifier: "APWalletDetailListCell")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "钱包明细"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.theme_backgroundColor = ["#fafafa"]

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletDetailCell: APWalletDetailListCell = APWalletDetailListCell.cellWithTableView(tableView) as! APWalletDetailListCell
        return walletDetailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(APProfitsDetailViewController(), animated: true)
    }
    
    

}
