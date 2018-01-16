//
//  APBaseQueryViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseQueryViewController: APBaseViewController {
    
    func ap_getStartDate() -> String {
        let startDate = datePickerFormsCell.leftHeadView.button.title.text!
        return startDate.replacingOccurrences(of: "/", with: "-")
    }
    
    func ap_getEndDate() -> String {
        let endDate = datePickerFormsCell.rightHeadView.button.title.text!
        return endDate.replacingOccurrences(of: "/", with: "-")
    }
    
    func ap_getPaymentWay() -> String {
        var returnValue: String = ""
        let paymentWay = pulldownController.leftPulldownView.button_text!
        if paymentWay == "银联快捷收款" {
            returnValue = "3"
        }
        else if paymentWay == "支付宝收款" {
            returnValue = "2"
        }
        else if paymentWay == "微信收款" {
            returnValue = "1"
        }
        return returnValue
    }
    
    func ap_getSettlementWay() -> String {
        return pulldownController.rightPulldownView.button_text!
    }
    
    func ap_tableView(tableView: UITableView, section: Int) -> Int {
        return 0
    }
    
    func ap_tableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func ap_tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        ap_setStatusBarStyle(.lightContent)
        view.addSubview(bg_imageView)
        view.addSubview(datePickerFormsCell)
        view.addSubview(tableView)
        view.addSubview(summaryDataView)
        view.addSubview(pulldownController)
        
        
        var margin : CGFloat = 0.0
        if K_Width < 375{
            margin = 10
        }
        else {
            margin = 20
        }
        
        bg_imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(85)
        }
        
        datePickerFormsCell.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
            make.top.equalTo(view)
            make.height.equalTo(44)
        }
        
        pulldownController.snp.makeConstraints { (make) in
            make.top.equalTo(datePickerFormsCell.snp.bottom)
            make.left.equalTo(view).offset(margin)
            make.right.equalTo(view).offset(-margin)
            make.height.equalTo(36)
        }
        
        summaryDataView.snp.makeConstraints { (make) in
            make.top.equalTo(bg_imageView.snp.bottom).offset(8)
            make.left.right.equalTo(view)
            make.height.equalTo(63)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(summaryDataView.snp.bottom).offset(15)
        }
    }

    lazy var bg_imageView : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "ReturnBillHead_BG"))
        return view
    }()
    
    lazy var datePickerFormsCell: APDatePickerFormsCell = {
        let view = APDatePickerFormsCell()
        return view
    }()
    
    lazy var pulldownController: APPulldownController = {
        let view = APPulldownController(targetVC: self)
        return view
    }()
    
    lazy var summaryDataView:APSummaryDataView = {
        let view = APSummaryDataView()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.AP_setupEmpty()
        view.theme_backgroundColor = ["#fafafa"]
        return view
    }()
}

extension APBaseQueryViewController:
    UITableViewDelegate,
    UITableViewDataSource  {
    
    //MARK: ---- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ap_tableView(tableView: tableView, section:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ap_tableView(tableView:tableView, cellForRowAt:indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ap_tableView(tableView: tableView, didSelectRowAt: indexPath)
    }
}

