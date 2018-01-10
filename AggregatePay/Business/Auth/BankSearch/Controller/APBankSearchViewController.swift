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
    
    private let searchBar = APSearchBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "开户行查询"
        
        self.ap_setStatusBarStyle(.lightContent)
        setUpNavi()
        layoutViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.editing(isEditing: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.editing(isEditing: false)
    }
    
    func requestData() {
        APBankSearchTool.queryCnapsListByBankName(params: request, success: { (response) in
            self.banks = response.coCnapsRespList!
            if self.banks.count < 1 {
                self.view.makeToast("请输入详细的关键字")
            } else {
                self.tableView.reloadData()
            }
        }) { (error) in
            self.view.makeToast(error.message)
        }
    }
    
    lazy var request: APSearchBankRequest = {
        let request = APSearchBankRequest()
        return request
    }()
    
    lazy private var headView: UIView = {
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 30))
        headView.backgroundColor = UIColor.clear
        return headView
    }()
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.text = "请选择银行"
        label.backgroundColor = headView.backgroundColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(hex6: 0x484848)
        return label
    }()
    
    lazy private var tableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.init(), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headView
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.init(hex6: 0xeeeeee)
        tableView.separatorInset = UIEdgeInsets.init()
        tableView.register(APSingleLabelCell.self, forCellReuseIdentifier: NSStringFromClass(APSingleLabelCell.self))
        tableView.rowHeight = 40
        return tableView
    }()
}

extension APBankSearchViewController: APSearchBarViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func setUpNavi() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: AP_navigationLeftItemImage(),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(backAction))
    }
    
    private func layoutViews() {
      
        searchBar.delegate = self
        searchBar.placeholder = "北京海淀"
        
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
    
    func searchButtonDidTap(keyword: String) {
        
        if keyword.count == 0 {
            view.makeToast("请输入关键字")
            return
        }
        request.bankName = keyword
        banks.removeAll()
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
        backAction()
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
}
