//
//  APBankSearchViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APSelectBankComplete = (_ bank: APBank) -> Void

class APBankSearchViewController: APBaseViewController {

    var banks: [APBank] = []
    var selectBankComplete: APSelectBankComplete?
    var tableView = UITableView.init(frame: CGRect.init(), style: .plain)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        layoutViews()
    }
    
    func requestData() {
        for _ in 0...100 {
            let bank = APBank()
            bank.bankName = "中国农业银行马甸东路支行"
            bank.bankCoupletNum = "12345"
            banks.append(bank)
        }
        tableView.reloadData()
    }
}

extension APBankSearchViewController: APSearchBarViewDelegate, UITableViewDelegate, UITableViewDataSource {
    private func layoutViews() {
        let searchBar = APSearchBarView()
        searchBar.delegate = self
        searchBar.textField.placeholder = "中国农业银行 北京 朝阳区"
        
        let headView = UIView()
        headView.backgroundColor = UIColor.clear
        let label = UILabel()
        label.text = "请选择银行"
        label.backgroundColor = headView.backgroundColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(hex6: 0x484848)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headView
        tableView.tableHeaderView?.height = 30
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.init(hex6: 0xeeeeee)
        tableView.separatorInset = UIEdgeInsets.init()
        tableView.register(APSingleLabelCell.self, forCellReuseIdentifier: NSStringFromClass(APSingleLabelCell.self))
        tableView.rowHeight = 40
        
        view.addSubview(searchBar)
        headView.addSubview(label)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(6)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(10)
        }
    }
}

extension APBankSearchViewController {
    
    func searchButtonDidTap() {
       requestData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(APSingleLabelCell.self), for: indexPath) as! APSingleLabelCell
        let bank = banks[indexPath.row]
        cell.label.text = bank.bankName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        let bank = banks[indexPath.row]
        selectBankComplete?(bank)
        navigationController?.popViewController()
        
    }
}
