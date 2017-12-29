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
class APWalletViewController: APBaseViewController{
    
    var amountSum: String?
    
    var getUserAccountInfoResquest: APGetUserAccountInfoResquest = APGetUserAccountInfoResquest()
    
    //MARK: ---- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "钱包"
        createSubViews()
        initNavigation()
        initHttpRequest()
    }

    //MARK: ---- action
    @objc func pushBillVC() {
        let billVC = APBillViewController()
        navigationController?.pushViewController(billVC, animated: true)
    }
    
    
    //MARK: ---- 懒加载
    lazy var tableView: UITableView = {
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

    lazy var headerView: APWalletHeaderView = {
        let view = APWalletHeaderView()
        view.frame = CGRect.init(x: 0, y: 0, width: K_Width, height: 160)
        return view
    }()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let view = APBarButtonItem.ap_barButtonItem(self ,title: "账单", action: #selector(pushBillVC))
        return view
    }()
    
    lazy var navigationBG: UIImage = {
        let image = UIImage.init(named: "Earning_head_bg")
        let newImage = image?.cropped(to: CGRect.init(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!*64/204))
        return newImage!
    }()
}

//MARK: ------------------------------ Extension

extension APWalletViewController {
    
    //MARK: ---- private
    private func createSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //初始化导航栏相关
    private func initNavigation() {
        vhl_setNavBarBackgroundImage(navigationBG)
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    //初始化网络请求相关
    private func initHttpRequest() {
        weak var weakSelf = self
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.httpGetUserAccountInfo()
        })
        view.AP_loadingBegin()
        httpGetUserAccountInfo()
    }
    
    //网络请求
    private func httpGetUserAccountInfo() {
        getUserAccountInfoResquest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl,
                          action: APHttpService.getUserAccountInfo,
                          params: getUserAccountInfoResquest,
                          aClass: APGetUserAccountInfoResponse.self,
                          success: { (baseResp) in
                            self.view.AP_loadingEnd()
                            self.tableView.mj_header.endRefreshing()
                            let getUserAccountInfoResponse = baseResp as! APGetUserAccountInfoResponse
                            self.amountSum = getUserAccountInfoResponse.drawAMoney
                            let amountNum = Double(self.amountSum!)! / 100.00
                            self.headerView.amountLabel.text = String(format: "%.2f", amountNum)

        }) { (baseError) in
            self.view.AP_loadingEnd()
            self.tableView.mj_header.endRefreshing()
            self.headerView.amountLabel.text = "0.00"
            self.view.makeToast(baseError.message)
        }
    }
}

//MARK: ------------ Delegate

extension APWalletViewController:
    UITableViewDelegate,
    UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let walletCell = APWalletCell.cellWithTableView(tableView) as! APWalletCell
        walletCell.titleLabel.text = "钱包明细"
        walletCell.iconImageView.theme_image = ["wallet_detail_cell_icon"]
        return walletCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let walletDetailList = APWalletDetailViewController()
        walletDetailList.amountSum = amountSum
        navigationController?.pushViewController(walletDetailList, animated: true)
    }
}
