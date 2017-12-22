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
    
    lazy var navigationBG: UIImage = {
        let image = UIImage.init(named: "Earning_head_bg")
        let newImage = image?.cropped(to: CGRect.init(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!*64/204))
        return newImage!
    }()
    
    //MARK: ---- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "钱包"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        self.vhl_setNavBarBackgroundImage(navigationBG)
        
        view.addSubview(tableView)

        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
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
        headerView.frame = CGRect.init(x: 0, y: 0, width: K_Width, height: 160)
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.tableHeaderView = headerView
        view.register(APWalletCell.self, forCellReuseIdentifier: "APWalletCell")
        return view
    }()

    
    
}
