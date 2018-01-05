//
//  APResultViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionResultViewController: APUnionPayBaseViewController,
UITableViewDelegate,
UITableViewDataSource {
    
    var resultDic: Dictionary<String, String>?
    
    lazy var headerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var headerTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .center
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        return view
    }()

    lazy var rightBarButtonItem: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "完成",
                                   style: UIBarButtonItemStyle.done,
                                   target: self,
                                   action: #selector(dismissGoHome))
        return view
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "订单详情"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.theme_backgroundColor = ["#fafafa"]
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(headerImageView)
        view.addSubview(headerTitleLabel)
        view.addSubview(tableView)
        
        headerImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view.snp.centerX)
            maker.top.equalTo(view.snp.top).offset(44)
            maker.width.equalTo(view.snp.width).multipliedBy(0.3)
            maker.height.equalTo(view.snp.width).multipliedBy(0.3)
        }
        
        headerTitleLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(headerImageView.snp.centerX)
            maker.top.equalTo(headerImageView.snp.bottom).offset(10)
            maker.width.equalTo(200)
            maker.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.left)
            maker.right.equalTo(view.snp.right)
            maker.bottom.equalTo(view.snp.bottom)
            maker.top.equalTo(headerTitleLabel.snp.bottom).offset(44)
        }
    }
    
    @objc func dismissGoHome() {
        ap_dismiss()
    }
    
    func ap_dismiss() {
        self.dismiss(animated: true) {
            let tabBarC = APPDElEGATE.window?.rootViewController as! APBaseTabBarViewController
            let selectVC = tabBarC.selectedViewController as! APBaseNavigationViewController
            let lastVC = selectVC.childViewControllers.last as! APBaseViewController
            lastVC.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //MARK: ---- 子类重载
    
    func numberRow(tableView: UITableView) -> Int {
        return 0
    }

    func ap_tableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRow(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ap_tableView(tableView: tableView, indexPath: indexPath)
        if  indexPath.row%2 == 0 {
            cell.backgroundColor = UIColor.white
            cell.contentView.backgroundColor = UIColor.white
        }
        else {
            cell.theme_backgroundColor = ["#fafafa"]
            cell.contentView.theme_backgroundColor = ["#fafafa"]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}












