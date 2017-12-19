//
//  APResultViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APCollectionResultViewController: APBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        view.register(APCollectionResultCell.self, forCellReuseIdentifier: "APCollectionResultCell")
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
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: ---- 子类重载
    
    func numberRow(tableView: UITableView) -> Int {
        return 0
    }
    
    func cellAttribute(collectionResultCell: APCollectionResultCell, indexPath: IndexPath) {
        
    }
    
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRow(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collectionResultCell: APCollectionResultCell = APCollectionResultCell.cellWithTableView(tableView) as! APCollectionResultCell
        if  indexPath.row%2 == 0 {
            collectionResultCell.backgroundColor = UIColor.white
            collectionResultCell.contentView.backgroundColor = UIColor.white
        }
        else {
            collectionResultCell.theme_backgroundColor = ["#fafafa"]
            collectionResultCell.contentView.theme_backgroundColor = ["#fafafa"]
        }
        cellAttribute(collectionResultCell: collectionResultCell, indexPath: indexPath)
        return collectionResultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}












