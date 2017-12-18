//
//  APCollectionPlaceViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 选择收款通道
 */
class APCollectionPlaceViewController: APBaseViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择收款通道"
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collectionPlaceCell: APCollectionPlaceCell = APCollectionPlaceCell.cellWithTableView(tableView) as! APCollectionPlaceCell
        collectionPlaceCell.titleLabel.text = "银联快捷收款"
        collectionPlaceCell.rateLabel.text = "费率：0.454%+3"
        return collectionPlaceCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(APPayEssentialViewController(), animated: true)
    }
    
    //MARK: ---- 懒加载
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APCollectionPlaceCell.self, forCellReuseIdentifier: "APCollectionPlaceCell")
        return view
    }()


}










