//
//  APBillViewController.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import PGDatePicker

class APBillViewController: APBaseViewController,
APBillSelectViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
PGDatePickerDelegate {

    var collectionView: UICollectionView?
    var selectTypeView:APBillSelectView?
    private var scrollerTypeFlag = false
    private var dateWayView: APBillDateWayView?
    private var datePickerView: PGDatePicker?
    
    func clickSelectBtn(index: Int) {
        self.scrollerTypeFlag = true
        self.collectionView?.setContentOffset(CGPoint.init(x: UIScreen.main.bounds.size.width * CGFloat(index), y: 0), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCreatViews()
        self.datePickerView = self.initCreatDateView()
    }
    
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
    
    func initCreatViews(){
        self.title = "账单"
        self.view.backgroundColor = UIColor(hex6: 0xf5f5f5)
        weak var weakSelf = self
        
        //创建头部的 账单类型
        let selectView = APBillSelectView.init(titleArray: ["交易查询","分润查询"])
        self.selectTypeView = selectView
        selectView.delegate = self
        self.view.addSubview(selectView)
        selectView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0);
            make.height.equalTo(40)
        }
        
        //日期 收款方式 结算方式的视图
        let wayView = APBillDateWayView.init()
        self.dateWayView = wayView
        self.view.addSubview(wayView)
        wayView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(80+10+60)
            make.top.equalTo(selectView.snp.bottom)
        }
        
        //数据的 滑动视图
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 264)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView = collectionView
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.register(APBillDetailCollectionViewCell.self, forCellWithReuseIdentifier: "APBillDetailCollectionViewCell")
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(wayView.snp.bottom).offset(10)
        }
        
        //收款方式选择的视图
        let collectionWayView = APBillSettleWayView.init(titleArray: ["全部",
                                                                      "银联快捷收款",
                                                                      "微信收款",
                                                                      "支付宝收款"])
        collectionWayView.isHidden = true
        self.view.addSubview(collectionWayView)
        collectionWayView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(wayView.snp.bottom).offset(-70)
        }
        
        //结算方式的选择的视图
        let settleWayView = APBillSettleWayView.init(titleArray: ["全部","D+0"])
        settleWayView.isHidden = true
        self.view.addSubview(settleWayView)
        settleWayView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(wayView.snp.bottom).offset(-70)
        }
        
        //MARK: ---- 点击 收款方式 结算方式 按钮的点击事件
        collectionWayView.clickBtnTypeAction { (btnTitle) in
            if btnTitle.count != 0{
                weakSelf?.dateWayView?.collectionWayLabel.text = btnTitle
            }
        }
        settleWayView.clickBtnTypeAction { (btnTitle) in
            if btnTitle.count != 0{
                weakSelf?.dateWayView?.settleWayLabel.text = btnTitle
            }
        }

        //MARK: ---- 点击 开始日期、截止日期、收款方式、结算方式  按钮的点击事件
        wayView.whenClickBtnBlock { (currentTitle, currentBtnType) in
            print(currentTitle,currentBtnType)
            
            if ((currentBtnType == APBillDateWayViewBtnType.StartDateBtn) ||
                (currentBtnType == APBillDateWayViewBtnType.EndDateBtn)){
                
                collectionWayView.titleBgView.snp.updateConstraints({ (make) in
                    make.height.equalTo(0)
                })
                settleWayView.titleBgView.snp.updateConstraints({ (make) in
                    make.height.equalTo(0)
                })
                UIView.animate(withDuration: 0.25, animations: {
                    collectionWayView.layoutIfNeeded()
                    settleWayView.layoutIfNeeded()
                    collectionWayView.isHidden = true
                    settleWayView.isHidden = true
                })
                
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy/MM/dd"
                let calculatedDate = Calendar.current.date(byAdding: Calendar.Component.month, value: -3, to: Date())
                let maxDate = dateformatter.date(from: (self.dateWayView?.endDateLabel.text)!)
                let minDate = dateformatter.date(from: (self.dateWayView?.startDateLabel.text)!)
                
                if (currentBtnType == APBillDateWayViewBtnType.StartDateBtn){
                    let datePickerView = self.initCreatDateView()
                    self.datePickerView = datePickerView
                    datePickerView.show()
                    
                    datePickerView.maximumDate = maxDate
                    datePickerView.minimumDate = calculatedDate
                }
                else{
                    let datePickerView = self.initCreatDateView()
                    datePickerView.show()
                    
                    datePickerView.maximumDate = Date()
                    datePickerView.minimumDate = minDate
                }
            }
            else if (currentBtnType == APBillDateWayViewBtnType.CollectionWayBtn){
                collectionWayView.titleBgView.snp.updateConstraints({ (make) in
                    make.height.equalTo(40)
                })
                settleWayView.titleBgView.snp.updateConstraints({ (make) in
                    make.height.equalTo(0)
                })
                UIView.animate(withDuration: 0.25, animations: {
                    collectionWayView.layoutIfNeeded()
                    collectionWayView.isHidden = false
                    settleWayView.isHidden = true
                })
            }
            else{
                collectionWayView.titleBgView.snp.updateConstraints({ (make) in
                    make.height.equalTo(0)
                })
                settleWayView.titleBgView.snp.updateConstraints({ (make) in
                    make.height.equalTo(40)
                })
                UIView.animate(withDuration: 0.25, animations: {
                    settleWayView.layoutIfNeeded()
                    settleWayView.isHidden = false
                    collectionWayView.isHidden = true
                })
            }
        }
    }
    
    //MARK: ---- PGDatePickerDelegate
    func datePicker(_ datePicker: PGDatePicker!,
                    didSelectDate dateComponents: DateComponents!) {
        let calendar = NSCalendar.current
        let dateStr = APDateTools.stringToDate(date: calendar.date(from: dateComponents)!,
                                               dateFormat: .deteFormatB)
        if datePicker == self.datePickerView {
            self.dateWayView?.startDateLabel.text = dateStr
        }
        else{
            self.dateWayView?.endDateLabel.text = dateStr
        }
    }

    //MARK: ---- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: APBillDetailCollectionViewCell.self, for: indexPath)
        return cell!
    }
    
    //MARK:UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollerTypeFlag = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.scrollerTypeFlag {
            self.selectTypeView?.setBtnIndex(index: Int(scrollView.contentOffset.x / UIScreen.main.bounds.size.width) )
        }
    }
}
