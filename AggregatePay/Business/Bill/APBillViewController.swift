//
//  APBillViewController.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import PGDatePicker

class APBillViewController: APBaseViewController{

    private var datePickerView: PGDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账单"
        self.view.backgroundColor = UIColor(hex6: 0xf5f5f5)
        createSubViews()
        registerCallBack()
    }
    
    func createSubViews() {
        
        self.datePickerView = self.initCreatDateView()
        
        self.view.addSubview(dateWayView)
        self.view.addSubview(tableView)
        self.view.addSubview(collectionWayView)
        self.view.addSubview(settleWayView)
        
        dateWayView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(80+10+60)
            make.top.equalTo(view.snp.top)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(dateWayView.snp.bottom).offset(10)
        }
        collectionWayView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(dateWayView.snp.bottom).offset(-70)
        }
        settleWayView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(dateWayView.snp.bottom).offset(-70)
        }
    }
    
    func registerCallBack() {
        
        weak var weakSelf = self
        //MARK: ---- 点击 收款方式 结算方式 按钮的点击事件
        collectionWayView.clickBtnTypeAction { (btnTitle) in
            if btnTitle.count != 0{
                weakSelf?.dateWayView.collectionWayLabel.text = btnTitle
            }
        }
        settleWayView.clickBtnTypeAction { (btnTitle) in
            if btnTitle.count != 0{
                weakSelf?.dateWayView.settleWayLabel.text = btnTitle
            }
        }
        
        //MARK: ---- 点击 开始日期、截止日期、收款方式、结算方式  按钮的点击事件
        dateWayView.whenClickBtnBlock { (currentTitle, currentBtnType) in
            if ((currentBtnType == APBillDateWayViewBtnType.StartDateBtn) ||
                (currentBtnType == APBillDateWayViewBtnType.EndDateBtn)){
                if (currentBtnType == APBillDateWayViewBtnType.StartDateBtn){
                    self.didStartDateBtn()
                }
                else{
                    self.didEndDateBtn()
                }
            }
            else if (currentBtnType == APBillDateWayViewBtnType.CollectionWayBtn){
                self.didCollectionWayBtn()
            }
            else{
                self.didSettleWayBtn()
            }
        }
    }
    
    
    //MARK: ----- init loading
    
    func initCreatDateView() -> PGDatePicker{
        
        let datePicker = PGDatePicker()
        datePicker.delegate = self
        datePicker.datePickerMode = .date
        datePicker.cancelButtonText = "取消"
        datePicker.cancelButtonFont = UIFont.systemFont(ofSize: 14)
        datePicker.cancelButtonTextColor = UIColor.init(hex6: 0x999999)
        datePicker.confirmButtonText = "确定"
        datePicker.confirmButtonFont = UIFont.systemFont(ofSize: 14)
        datePicker.confirmButtonTextColor = UIColor.init(hex6: 0xc8a556)
        datePicker.titleLabel.text = ""
        datePicker.titleLabel.font = UIFont.systemFont(ofSize: 16)
        datePicker.titleLabel.textColor = UIColor.init(hex6: 0x484848)
        datePicker.lineBackgroundColor = UIColor.init(hex6: 0xe5e5e5)
        datePicker.textColorOfSelectedRow = UIColor.init(hex6: 0x484848)
        datePicker.textColorOfOtherRow = UIColor.init(hex6: 0x999999)
        return datePicker
    }
    
    //MARK: ---- lazy loading
    
    //日期 收款方式 结算方式的视图
    lazy var dateWayView: APBillDateWayView = {
        let view = APBillDateWayView.init()
        return view
    }()
    
    //收款方式选择的视图
    lazy var collectionWayView:APBillSettleWayView = {
        let view = APBillSettleWayView(titleArray: ["全部", "银联快捷收款", "微信收款", "支付宝收款"])
        view.isHidden = true
        return view
    }()
    
    //结算方式的选择的视图
    lazy var settleWayView:APBillSettleWayView = {
        let view = APBillSettleWayView(titleArray: ["D+0"])
        view.isHidden = true
        return view
    }()
    
    //列表
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APWalletDetailListCell.self, forCellReuseIdentifier: "APWalletDetailListCell")
        return view
    }()
    
}

//MARK: ------------------------- Private

extension APBillViewController {

    private func dateFormatter(startDate: String,
                       endDate: String,
                       result:(_ calculate: Date, _ maxDate: Date, _ minDate: Date) -> Void) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let calculatedDate = Calendar.current.date(byAdding: Calendar.Component.month, value: -3, to: Date())
        let maxDate = dateformatter.date(from: endDate)
        let minDate = dateformatter.date(from: startDate)
        result(calculatedDate!, maxDate!, minDate!)
    }

    //点击选择开始日期按钮和结束日期按钮
    private func didSelectDateBtn() {
        self.collectionWayView.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        self.settleWayView.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        UIView.animate(withDuration: 0.25, animations: {
            self.collectionWayView.layoutIfNeeded()
            self.settleWayView.layoutIfNeeded()
            self.collectionWayView.isHidden = true
            self.settleWayView.isHidden = true
        })
    }
    
    //点击选择开始日期按钮
    private func didStartDateBtn() {
        didSelectDateBtn()
        let startDate = self.dateWayView.startDateLabel.text!
        let endDate = self.dateWayView.endDateLabel.text!
        dateFormatter(startDate: startDate,
                      endDate: endDate)
        { (calculate, maxDate, minDate) in
            let datePickerView = self.initCreatDateView()
            datePickerView.show()
            datePickerView.maximumDate = maxDate
            datePickerView.minimumDate = calculate
            self.datePickerView = datePickerView
        }
    }
    
    //点击选择结束日期按钮
    private func didEndDateBtn() {
        didSelectDateBtn()
        let startDate = self.dateWayView.startDateLabel.text!
        let endDate = self.dateWayView.endDateLabel.text!
        dateFormatter(startDate: startDate,
                      endDate: endDate)
        { (calculate, maxDate, minDate) in
            let datePickerView = self.initCreatDateView()
            datePickerView.show()
            datePickerView.maximumDate = Date()
            datePickerView.minimumDate = minDate
        }
    }
    
    //点击收款方式按钮
    private func didCollectionWayBtn() {
        if !self.collectionWayView.isHidden {
            return
        }
        self.collectionWayView.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(40)
        })
        self.settleWayView.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        self.collectionWayView.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.collectionWayView.layoutIfNeeded()
            self.collectionWayView.alpha = 1
            self.collectionWayView.isHidden = false
            self.settleWayView.alpha = 0
            self.settleWayView.isHidden = true
        })
    }
    
    //点击结算方式按钮
    private func didSettleWayBtn() {
        if !self.settleWayView.isHidden {
            return
        }
        self.collectionWayView.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        self.settleWayView.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(40)
        })
        
        self.settleWayView.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.settleWayView.layoutIfNeeded()
            self.settleWayView.alpha = 1
            self.settleWayView.isHidden = false
            self.collectionWayView.alpha = 0
            self.collectionWayView.isHidden = true
        })
    }
}


//MARK: ------------------------- Delegate

extension APBillViewController:
    UITableViewDelegate,
    UITableViewDataSource ,
    PGDatePickerDelegate  {
    
    //MARK: ---- PGDatePickerDelegate
    func datePicker(_ datePicker: PGDatePicker!, didSelectDate dateComponents: DateComponents!) {
        let calendar = NSCalendar.current
        let dateStr = APDateTools.stringToDate(date: calendar.date(from: dateComponents)!, dateFormat: .deteFormatB)
        if datePicker == self.datePickerView {
            self.dateWayView.startDateLabel.text = dateStr
        }
        else{
            self.dateWayView.endDateLabel.text = dateStr
        }
    }
    
    //MARK: ---- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
