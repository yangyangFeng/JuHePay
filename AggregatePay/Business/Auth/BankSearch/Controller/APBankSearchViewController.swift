//
//  APBankSearchViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBankSearchViewController: APBaseViewController {

    var banks: [APBank] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()
    }
    
    func requestData() {
        for _ in 0...100 {
            let bank = APBank()
            bank.bankName = "中国农业银行马甸东路支行"
            banks.append(bank)
        }
    }
}

extension APBankSearchViewController: APSearchBarViewDelegate, UITableViewDelegate, UITableViewDataSource {
    private func layoutViews() {
        let searchBar = APSearchBarView()
        searchBar.delegate = self
        searchBar.textField.placeholder = "中国农业银行 北京 朝阳区"
        
        let tableView = UITableView.init(frame: CGRect.init(), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
    }
   
}

extension APBankSearchViewController {
    
    func searchButtonDidTap() {
       requestData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(APSingleLabelCell.self), for: indexPath) as! APSingleLabelCell
        let bank = banks[indexPath.row]
        cell.label.text = bank.bankName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: false)
        
    }
}
