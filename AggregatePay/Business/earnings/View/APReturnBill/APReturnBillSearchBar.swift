//
//  APReturnBillSearchBar.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

import PGDatePicker

extension APReturnBillSearchBar: PGDatePickerDelegate {
    
    func datePicker(_ datePicker: PGDatePicker!, didSelectDate dateComponents: DateComponents!) {
        let calendar = NSCalendar.current
        if datePicker == currentPicker {
            leftHeadView.button.title.text = APDateTools.stringToDate(date: calendar.date(from: dateComponents)!, dateFormat: APDateTools.APDateFormat.deteFormatB)
        }
        else
        {
            rightHeadView.button.title.text = APDateTools.stringToDate(date: calendar.date(from: dateComponents)!, dateFormat: APDateTools.APDateFormat.deteFormatB)
        }
        if conversionDate(leftHeadView.button.title.text!) > conversionDate(rightHeadView.button.title.text!){
            leftHeadView.button.title.text = APDateTools.stringToDate(date: startDate(interval), dateFormat: APDateTools.APDateFormat.deteFormatB)
        }
    }
}

class APReturnBillSearchBar: UIView {

    var interval : Int = 1 //defaule is 1.
    var maxInterval : Int = 6 //defaule is 6.
    
    let bg_imageView : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "ReturnBillHead_BG"))
        return view
    }()
    
    let line : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "ReturnSearchLine"))
        return view
    }()
    
    let verticalLine : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "ReturnSearchVerticalLine"))
        return view
    }()
    
    var currentPicker : PGDatePicker?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let to : UILabel = {
            let view = UILabel()
            view.text = "至"
            view.font = UIFont.systemFont(ofSize: 12)
            view.theme_textColor = ["#4c370b"]
            return view
        }()
        
        addSubview(bg_imageView)
        addSubview(line)
        addSubview(verticalLine)
        addSubview(leftHeadView)
        addSubview(rightHeadView)
        addSubview(to)
        addSubview(leftBottomView)
        addSubview(rightBottomView)
        
        bg_imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        line.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(2.5)
        }
        verticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(2.5)
            make.centerX.equalTo(snp.centerX).offset(0)
            make.height.equalTo(42)
            make.bottom.equalTo(-8)
        }
        to.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(line.snp.top).offset(0)
            make.centerX.equalTo(snp.centerX).offset(0)
            make.width.equalTo(12)
        }
        var margin : CGFloat = 0.0
        if K_Width < 375{
            margin = 10
        }
        else
        {
            margin = 20
        }
        leftHeadView.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.top.equalTo(0)
            make.bottom.equalTo(line.snp.top).offset(0)
            make.right.equalTo(to.snp.left).offset(-8)
        }
        rightHeadView.snp.makeConstraints { (make) in
            make.right.equalTo(-margin)
            make.top.equalTo(0)
            make.bottom.equalTo(line.snp.top).offset(0)
            make.left.equalTo(to.snp.right).offset(8)
        }
        leftBottomView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.top.equalTo(line.snp.bottom).offset(0)
            make.right.equalTo(verticalLine.snp.left).offset(0)
        }
        rightBottomView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.left.equalTo(verticalLine.snp.right).offset(0)
            make.top.equalTo(line.snp.bottom).offset(0)
        }
    }

    func conversionDate(_ str : String) -> Date{
        let calendar = NSCalendar.current
        let arrs : [String] = str.components(separatedBy: "/")
        
        var components = DateComponents()
        components.year = Int(arrs[0])
        components.month = Int(arrs[1])
        components.day = Int(arrs[2])
        return calendar.date(from: components)!
    }
    func conversionString(_ date : Date) -> String
    {
        let str : String = APDateTools.stringToDate(date: date as Date, dateFormat: APDateTools.APDateFormat.deteFormatB)
        return str
    }
    
    func startDate(_ interval : Int) -> Date {
        let nowDate = conversionDate(rightHeadView.button.title.text!)
        //Date.init(timeIntervalSinceNow: 0)
        let calendar = NSCalendar.current
        
        let dateComponents = calendar.dateComponents([.year,.month, .day, .hour,.minute,.second], from: nowDate as Date)
        
        var components = DateComponents()
        components.year = dateComponents.year
        components.month = (dateComponents.month! - interval)
        components.day = dateComponents.day
        components.timeZone = TimeZone(abbreviation: "GMT")
        let endDate = calendar.date(from: components)
        return endDate!
    }
    
    func endDate() -> Date {
        let endDate : Date = Date.init(timeIntervalSinceNow: 0)
        return endDate
    }
    
    func datePicker() -> PGDatePicker {
        let datePicker = PGDatePicker()
        datePicker.delegate = self
        
        //        datePicker.titleLabel.text = "PGDatePicker"
        //设置线条的颜色
        datePicker.lineBackgroundColor = UIColor.clear
        //设置选中行的字体颜色
        datePicker.textColorOfSelectedRow = UIColor.init(hex6: 0x484848)
        //设置未选中行的字体颜色
        datePicker.textColorOfOtherRow = UIColor.init(hex6: 0x999999)
        
        //设置取消按钮的字体颜色
        datePicker.cancelButtonTextColor = UIColor.init(hex6: 0x999999)
        //设置取消按钮的字
        datePicker.cancelButtonText = "取消"
        //设置取消按钮的字体大小
        datePicker.cancelButtonFont = UIFont.boldSystemFont(ofSize: 14)
        
        //设置确定按钮的字体颜色
        datePicker.confirmButtonTextColor = UIColor.init(hex6: 0xc8a556)
        //设置确定按钮的字
        datePicker.confirmButtonText = "确定"
        //设置确定按钮的字体大小
        datePicker.confirmButtonFont = UIFont.boldSystemFont(ofSize: 14)
        datePicker.datePickerMode = .date
        
//        datePicker.minimumDate = startDate(interval)
        datePicker.maximumDate = endDate()
        return datePicker
    }
    
    lazy var leftHeadView : APReturnBillSearchHeadView = {
        let view = APReturnBillSearchHeadView()
        view.button.button.addTarget(self, action: #selector(startAction), for: UIControlEvents.touchUpInside)
        view.title.text = "开始日期"
        view.button.title.text = startStr
        return view
    }()
    
    lazy var rightHeadView : APReturnBillSearchHeadView = {
        let view = APReturnBillSearchHeadView()
        view.button.button.addTarget(self, action: #selector(endAction), for: UIControlEvents.touchUpInside)
        view.title.text = "截止日期"
        view.button.title.text = endStr
        //        view.button.title.text = "2017/11/03"
        return view
    }()
    
    lazy var endStr: String = {
        let endDate : Date = Date.init(timeIntervalSinceNow: 0)
        let str : String = APDateTools.stringToDate(date: endDate as Date, dateFormat: APDateTools.APDateFormat.deteFormatB)
        return str
    }()
    
    lazy var startStr: String = {
        let str : String = APDateTools.stringToDate(date: startDate(interval), dateFormat: APDateTools.APDateFormat.deteFormatB)
        return str
    }()
    
    
    @objc func startAction()
    {
        let picker = datePicker()
        let selectDate = APDateTools.dateToString(string: leftHeadView.button.title.text!, dateFormat: APDateTools.APDateFormat.deteFormatB)
        picker.minimumDate = startDate(maxInterval)
        picker.maximumDate = conversionDate(rightHeadView.button.title.text!)
        picker.setDate(selectDate, animated: false)
        picker.show()
        currentPicker = picker
    }
    
    @objc func endAction()
    {
        let picker = datePicker()
        let selectDate = APDateTools.dateToString(string: rightHeadView.button.title.text!, dateFormat: APDateTools.APDateFormat.deteFormatB)
        picker.setDate(selectDate, animated: false)
        picker.show()
    }
    
    let leftBottomView : APReturnBillSearchBarSubView = {
        let view = APReturnBillSearchBarSubView()
        view.iconImageView.image = UIImage.init(named: "Earnings_numer_icon")
        view.topTitle.text = "分润笔数"
        view.title.text = "3"
        return view
    }()
    
    let rightBottomView : APReturnBillSearchBarSubView = {
        let view = APReturnBillSearchBarSubView()
        view.iconImageView.image = UIImage.init(named: "Earnings_sum_icon")
        view.topTitle.text = "分润总额"
        view.title.text = "11100.00"
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class APReturnBillSearchHeadView: UIView {
    let title : UILabel = {
        let view = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 20))
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#4c370b"]
        view.textAlignment = .left
        view.text = "开始日期"
        return view
    }()
    
    let button : APArrowButton = {
        let view = APArrowButton()
        var margin : CGFloat = 12.0
        if K_Width < 375{
            view.margin = 2
        }
        return view
    }()
    
    let my_maskView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        view.alpha = 0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(button)
        addSubview(my_maskView)

        title.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(title.requiredWidth)
            make.centerY.equalTo(snp.centerY).offset(0)
        }
        button.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.left.equalTo(title.snp.right).offset(0)
            make.centerY.equalTo(snp.centerY).offset(0)
        }
        my_maskView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) {
            self.my_maskView.alpha = 1
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2) {
            self.my_maskView.alpha = 0
        }
    }
}

class APReturnBillSearchBarSubView: UIView {
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.theme_textColor = ["#4c370b"]
        return view
    }()
    
    var iconImageView : UIImageView!
    var topTitle : UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView.init(image: UIImage.init(named: "Earnings_numer_icon"))
        topTitle = UILabel()
        topTitle.font = UIFont.systemFont(ofSize: 12)
        topTitle.theme_textColor = ["#4c370b"]
        
        topTitle.text = "分润笔数"
        
        let width : CGFloat = topTitle.requiredWidth
        
        addSubview(iconImageView)
        addSubview(topTitle)
        addSubview(title)
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY).offset(0)
            make.centerX.equalTo(snp.centerX).offset(-width/2.0-4)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        topTitle.snp.makeConstraints { (make) in
            make.top.equalTo(11)
            make.left.equalTo(iconImageView.snp.right).offset(9)
        }
        title.snp.makeConstraints { (make) in
            make.centerX.equalTo(topTitle.snp.centerX).offset(0)
            make.top.equalTo(topTitle.snp.bottom).offset(3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
