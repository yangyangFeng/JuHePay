//
//  APReturnBillSearchBar.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

import PGDatePicker
//import PGD
extension APReturnBillSearchBar: PGDatePickerDelegate {
    func datePicker(_ datePicker: PGDatePicker!, didSelectDate dateComponents: DateComponents!) {
        print("dateComponents = ", dateComponents)
    }
}

class APReturnBillSearchBar: UIView {

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
    
    let leftHeadView : APReturnBillSearchHeadView = {
        let view = APReturnBillSearchHeadView()
        view.button.button.addTarget(self, action: #selector(startAction), for: UIControlEvents.touchUpInside)
        view.title.text = "开始日期"
        view.button.title.text = "2017/10/03"
        return view
    }()
    
    let rightHeadView : APReturnBillSearchHeadView = {
        let view = APReturnBillSearchHeadView()
        view.button.button.addTarget(self, action: #selector(endAction), for: UIControlEvents.touchUpInside)
        view.title.text = "截止日期"
        view.button.title.text = "2017/11/03"
        return view
    }()
    
    @objc func startAction()
    {
        let datePicker = PGDatePicker()
        datePicker.delegate = self
        datePicker.show()
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
    }
    @objc func endAction()
    {
        
    }
    
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
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class APArrowButton : UIView {
    
    var margin : CGFloat = 12
    
    let rightArrow : UIImageView = {
        let view = UIImageView(image: UIImage.init(named: "Mine_head_arrow"))
        return view
    }()
    
    var title : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.init(hex6: 0x4c370b)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    let button : UIButton = {
        let view = UIButton(type: UIButtonType.custom)
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rightArrow)
        addSubview(title)
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightArrow.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(snp.centerY).offset(0)
            make.right.equalTo(0)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(snp.centerY).offset(0)
            make.right.equalTo(rightArrow.snp.left).offset(-margin)
        }
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }

    }
    
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
