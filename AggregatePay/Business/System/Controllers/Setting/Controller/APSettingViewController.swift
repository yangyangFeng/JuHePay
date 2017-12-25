//
//  APSettingViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSettingViewController: APBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    lazy var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["修改密码",
                                            "找回密码"])
        return arr
    }()
    
    lazy var describes : NSArray = {
        var arr : NSArray = NSArray(array: ["建议您定期更改密码以保护账户安全",
                                            "若忘记密码可以通过找回密码找回"])
        return arr
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APSettingCell.self, forCellReuseIdentifier: "APSettingCell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalTo(view)
        }
    }
    
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell: APSettingCell = APSettingCell.cellWithTableView(tableView) as! APSettingCell
        settingCell.titleLabel.text = titles.object(at: indexPath.row) as? String
        settingCell.describeLabel.text = describes.object(at: indexPath.row) as? String
        return settingCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(APModifyViewController(),
                                                     animated: true)
        }
        else if indexPath.row == 1 {
            navigationController?.pushViewController(APForgetFirstStepViewController(),
                                                     animated: true)
        }
        
    }
    
    
    
    

}











