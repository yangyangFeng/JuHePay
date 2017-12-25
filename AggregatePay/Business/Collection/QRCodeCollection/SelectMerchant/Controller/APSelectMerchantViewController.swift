//
//  APSelectMerchantViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APSelectMerchantSuccess = (_ mccModel: APMCCModel) -> Void

class APSelectMerchantViewController: APBaseViewController,
UITableViewDelegate,
UITableViewDataSource {

    var selectMccModel: APMCCModel?
    let defaultMccModel: APMCCModel = APMCCModel()
    var selectMerchantBlock: APSelectMerchantSuccess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择商户类型"
        view.theme_backgroundColor = ["#fafafa"]
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        view.AP_loadingBegin()
        weak var weakSelf = self
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.startHttpRequest()
        })
    }
    
    func startHttpRequest() {
        tableView.mj_header.endRefreshing()
        tableView.reloadData()
        view.AP_loadingEnd() 
    }
    
    //MARK: ---- delegate
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectMerchantCell: APSelectMerchantCell = APSelectMerchantCell.cellWithTableView(tableView) as! APSelectMerchantCell
        let mccModel: APMCCModel = arr.object(at: indexPath.row) as! APMCCModel
        selectMerchantCell.mccModel(mccModel: mccModel,
                                    selectMccModel: (selectMccModel ?? defaultMccModel)!)
        return selectMerchantCell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let mccModel: APMCCModel = arr.object(at: indexPath.row) as! APMCCModel
        selectMerchantBlock?(mccModel)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: --- lazy loading
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.AP_setupEmpty()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APSelectMerchantCell.self,
                      forCellReuseIdentifier: "APSelectMerchantCell")
        return view
    }()
    
    lazy var arr : NSArray = {
        let mccModel1: APMCCModel = APMCCModel()
        mccModel1.mccId = 1
        mccModel1.mccName = "aaa1"
        
        let mccModel2: APMCCModel = APMCCModel()
        mccModel2.mccId = 2
        mccModel2.mccName = "aaa2"
        
        return NSArray(array: [mccModel1, mccModel2])
    }()

}
