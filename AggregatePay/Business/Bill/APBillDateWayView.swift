//
//  APBillDateWayView.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/15.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum APBillDateWayViewBtnType: Int{
    case StartDateBtn
    case EndDateBtn
    case CollectionWayBtn
    case SettleWayBtn
}

typealias DateOrWayBlock = (_ currentTitle: String,_ index: APBillDateWayViewBtnType) -> Void

class APBillDateWayView: UIView {

    private var startDateLabel = UILabel()
    private var endDateLabel = UILabel()
    private var collectionWayLabel = UILabel()
    private var settleWayLabel = UILabel()
    var btnClickBlock: DateOrWayBlock?
    
    func whenClickBtnBlock(btnBlock: @escaping DateOrWayBlock){
        self.btnClickBlock = btnBlock
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.initCreatViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCreatViews(){
        
        let waySelectView = UIView()
        waySelectView.backgroundColor = UIColor(hex6: 0xdcd1c3)
        waySelectView.alpha = 0.5
        self.addSubview(waySelectView)
        waySelectView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(80)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex6: 0xcabba5)
        waySelectView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
        }
        let bottomBgView = UIView()
        waySelectView.addSubview(bottomBgView)
        bottomBgView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
        }
        
        let collectionWayLabel = UILabel()
        collectionWayLabel.text = "收款方式:"
        collectionWayLabel.textColor = UIColor(hex6: 0x4c370b)
        collectionWayLabel.font = UIFont.systemFont(ofSize: 12)
        let collectionWayLabelString: NSString = NSString.init(string: collectionWayLabel.text!)
        let collectionWayLabelWidth = collectionWayLabelString.boundingRect(with: CGSize(width: 100,height: 15), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: collectionWayLabel.font], context: nil).width
        waySelectView.addSubview(collectionWayLabel)
        collectionWayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView)
            make.height.equalTo(14)
            make.width.equalTo(collectionWayLabelWidth+5)
            make.centerY.equalTo(bottomBgView)
        }
        
        let collectionWayBtn = UIButton()
        collectionWayBtn.tag = 101
        collectionWayBtn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
        collectionWayBtn.backgroundColor = UIColor.white
        waySelectView.addSubview(collectionWayBtn)
        collectionWayBtn.snp.makeConstraints { (make) in
            make.left.equalTo(collectionWayLabel.snp.right)
            make.right.equalTo(waySelectView.snp.centerX).offset(-10)
            make.height.equalTo(25)
            make.centerY.equalTo(bottomBgView)
        }
        let wayImageView = UIImageView()
        let wayImage = UIImage(named:"Bill_Arrow_Default")
        wayImageView.image = wayImage
        collectionWayBtn.addSubview(wayImageView)
        wayImageView.snp.makeConstraints { (make) in
            make.height.equalTo((wayImage?.size.height)!)
            make.width.equalTo((wayImage?.size.width)!)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-2)
        }
        let wayLabel = UILabel()
        self.collectionWayLabel = wayLabel
        wayLabel.text = "银联快捷收款"
        wayLabel.textAlignment = NSTextAlignment.center
        wayLabel.adjustsFontSizeToFitWidth = true
        wayLabel.font = UIFont.systemFont(ofSize: 12)
        wayLabel.textColor = UIColor(hex6: 0x4c370b)
        collectionWayBtn.addSubview(wayLabel)
        wayLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(wayImageView.snp.left)
        }
        
        let settleWayLabel = UILabel()
        settleWayLabel.text = "结算方式:"
        settleWayLabel.textAlignment = NSTextAlignment.left
        settleWayLabel.textColor = UIColor(hex6: 0x4c370b)
        settleWayLabel.font = UIFont.systemFont(ofSize: 12)
        waySelectView.addSubview(settleWayLabel)
        settleWayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(waySelectView.snp.centerX).offset(10)
            make.height.equalTo(14)
            make.width.equalTo(collectionWayLabelWidth+5)
            make.centerY.equalTo(bottomBgView)
        }
        
        let settleWayBtn = UIButton()
        settleWayBtn.tag = 102
        settleWayBtn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
        settleWayBtn.backgroundColor = UIColor.white
        waySelectView.addSubview(settleWayBtn)
        settleWayBtn.snp.makeConstraints { (make) in
            make.left.equalTo(settleWayLabel.snp.right)
            make.width.equalTo(collectionWayLabelWidth-20)
            make.height.equalTo(25)
            make.centerY.equalTo(bottomBgView)
        }
        let settleImageView = UIImageView()
        let settleImage = UIImage(named:"Bill_Arrow_Default")
        settleImageView.image = settleImage
        settleWayBtn.addSubview(settleImageView)
        settleImageView.snp.makeConstraints { (make) in
            make.height.equalTo((settleImage?.size.height)!)
            make.width.equalTo((settleImage?.size.width)!)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-2)
        }
        let settleLabel = UILabel()
        self.settleWayLabel = settleLabel
        settleLabel.text = "T+N"
        settleLabel.textAlignment = NSTextAlignment.center
        settleLabel.adjustsFontSizeToFitWidth = true
        settleLabel.font = UIFont.systemFont(ofSize: 12)
        settleLabel.textColor = UIColor(hex6: 0x4c370b)
        settleWayBtn.addSubview(settleLabel)
        settleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(settleImageView.snp.left)
        }

        let dateCentreLabel = UILabel()
        dateCentreLabel.text = "至"
        dateCentreLabel.font = UIFont.systemFont(ofSize: 12)
        dateCentreLabel.textColor = UIColor(hex6: 0x4c370b)
        waySelectView.addSubview(dateCentreLabel)
        dateCentreLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().dividedBy(2.0)
            make.height.equalTo(14)
            make.width.equalTo(12)
        }
        let dateStartLabel = UILabel()
        dateStartLabel.text = "开始日期"
        dateStartLabel.font = UIFont.systemFont(ofSize: 12)
        dateStartLabel.textColor = UIColor(hex6: 0x4c370b)
        waySelectView.addSubview(dateStartLabel)
        dateStartLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().dividedBy(2.0)
            make.height.equalTo(14)
            make.left.equalTo(lineView)
            make.width.equalTo(collectionWayLabelWidth)
        }
        
        let dateStartBtn = UIButton()
        dateStartBtn.tag = 103
        dateStartBtn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
        waySelectView.addSubview(dateStartBtn)
        dateStartBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
            make.left.equalTo(collectionWayBtn).offset(-5)
            make.right.equalTo(collectionWayBtn)
        }
        let dateStartImageView = UIImageView()
        let dateStartImage = UIImage(named:"Mine_head_arrow")
        dateStartImageView.image = dateStartImage
        dateStartBtn.addSubview(dateStartImageView)
        dateStartImageView.snp.makeConstraints { (make) in
            make.height.equalTo((dateStartImage?.size.height)!)
            make.width.equalTo((dateStartImage?.size.width)!)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        let factDateStartLabel = UILabel()
        self.startDateLabel = factDateStartLabel
        factDateStartLabel.text = "2017/12/19"
        factDateStartLabel.textAlignment = NSTextAlignment.center
        factDateStartLabel.adjustsFontSizeToFitWidth = true
        factDateStartLabel.font = UIFont.systemFont(ofSize: 14)
        factDateStartLabel.textColor = UIColor(hex6: 0x4c370b)
        dateStartBtn.addSubview(factDateStartLabel)
        factDateStartLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateStartImageView)
            make.height.equalTo(16)
            make.left.equalToSuperview()
            make.right.equalTo(dateStartImageView.snp.left).offset(-2)
        }

        
        let dateEndLabel = UILabel()
        dateEndLabel.text = "截止日期"
        dateEndLabel.font = UIFont.systemFont(ofSize: 12)
        dateEndLabel.textColor = UIColor(hex6: 0x4c370b)
        waySelectView.addSubview(dateEndLabel)
        dateEndLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateCentreLabel)
            make.height.equalTo(14)
            make.left.equalTo(settleWayLabel)
            make.width.equalTo(collectionWayLabelWidth)
        }
        
        let dateEndBtn = UIButton()
        dateEndBtn.tag = 104
        dateEndBtn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
        waySelectView.addSubview(dateEndBtn)
        dateEndBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(lineView.snp.top)
            make.left.equalTo(settleWayBtn).offset(-5)
            make.right.equalTo(lineView)
        }
        let dateEndImageView = UIImageView()
        let dateEndImage = UIImage(named:"Mine_head_arrow")
        dateEndImageView.image = dateEndImage
        dateEndBtn.addSubview(dateEndImageView)
        dateEndImageView.snp.makeConstraints { (make) in
            make.height.equalTo((dateEndImage?.size.height)!)
            make.width.equalTo((dateEndImage?.size.width)!)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        let factDateEndLabel = UILabel()
        self.endDateLabel = factDateEndLabel
        factDateEndLabel.text = "2017/12/19"
        factDateEndLabel.textAlignment = NSTextAlignment.center
        factDateEndLabel.adjustsFontSizeToFitWidth = true
        factDateEndLabel.font = UIFont.systemFont(ofSize: 14)
        factDateEndLabel.textColor = UIColor(hex6: 0x4c370b)
        dateEndBtn.addSubview(factDateEndLabel)
        factDateEndLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateEndImageView)
            make.height.equalTo(16)
            make.left.equalToSuperview()
            make.right.equalTo(dateEndImageView.snp.left).offset(-2)
        }
        
        
        let dealView = UIView()
        dealView.backgroundColor = UIColor.white
        self.addSubview(dealView)
        dealView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(waySelectView.snp.bottom).offset(10)
            make.height.equalTo(60)
        }
        
        let verLineView = UIView()
        verLineView.backgroundColor = UIColor(hex6: 0xcabba5)
        dealView.addSubview(verLineView)
        verLineView.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
        }
        let rightBgView = UIView()
        dealView.addSubview(rightBgView)
        rightBgView.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(verLineView.snp.right)
        }
        
        let dealNumTitleLabel = UILabel()
        dealNumTitleLabel.text = "交易笔数"
        dealNumTitleLabel.font = UIFont.systemFont(ofSize: 12)
        dealNumTitleLabel.textColor = UIColor(hex6: 0x4c370b)
        let dealNumLabelString: NSString = NSString.init(string: dealNumTitleLabel.text!)
        let dealNumLabelWidth = dealNumLabelString.boundingRect(with: CGSize(width: 100,height: 15), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: dealNumTitleLabel.font], context: nil).width
        dealView.addSubview(dealNumTitleLabel)
        dealNumTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(17)
            make.height.equalTo(14)
            make.width.equalTo(dealNumLabelWidth+5)
            make.centerX.equalTo(dealView).dividedBy(2.0)
        }
        
        let dealNumImageView = UIImageView()
        dealNumImageView.image = UIImage(named:"Bill_Number")
        dealView.addSubview(dealNumImageView)
        dealNumImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalTo(dealNumTitleLabel.snp.left).offset(-5)
        }
        
        let dealNumLabel = UILabel()
        dealNumLabel.text = "45678"
        dealNumLabel.textAlignment = NSTextAlignment.center
        dealNumLabel.font = UIFont.systemFont(ofSize: 14)
        dealView.addSubview(dealNumLabel)
        dealNumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(14)
            make.top.equalTo(dealNumImageView.snp.bottom).offset(-3)
            make.right.equalTo(verLineView.snp.left).offset(-5)
        }
        
        
        let dealAmountTitleLabel = UILabel()
        dealAmountTitleLabel.text = "交易总额"
        dealAmountTitleLabel.font = UIFont.systemFont(ofSize: 12)
        dealAmountTitleLabel.textColor = UIColor(hex6: 0x4c370b)
        dealView.addSubview(dealAmountTitleLabel)
        dealAmountTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(17)
            make.height.equalTo(14)
            make.width.equalTo(dealNumLabelWidth+5)
            make.centerX.equalTo(rightBgView)
        }
        
        let dealAmountImageView = UIImageView()
        dealAmountImageView.image = UIImage(named:"Bill_Amount")
        dealView.addSubview(dealAmountImageView)
        dealAmountImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalTo(dealAmountTitleLabel.snp.left).offset(-5)
        }
        
        let dealAmountLabel = UILabel()
        dealAmountLabel.text = "45678"
        dealAmountLabel.textAlignment = NSTextAlignment.center
        dealAmountLabel.font = UIFont.systemFont(ofSize: 14)
        dealView.addSubview(dealAmountLabel)
        dealAmountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(verLineView.snp.right).offset(-5)
            make.height.equalTo(14)
            make.top.equalTo(dealAmountImageView.snp.bottom).offset(-3)
            make.right.equalToSuperview()
        }
    }

    @objc func btnAction(_ btn: UIButton) {
        
        var currentTitle: String?
        var index: APBillDateWayViewBtnType?
        
        if btn.tag == 101 {
            currentTitle = self.collectionWayLabel.text!
            index = APBillDateWayViewBtnType.CollectionWayBtn
        }else if btn.tag == 102{
            currentTitle = self.settleWayLabel.text!
            index = APBillDateWayViewBtnType.SettleWayBtn
        }else if btn.tag == 103{
            currentTitle = self.startDateLabel.text!
            index = APBillDateWayViewBtnType.StartDateBtn
        }else{
            currentTitle = self.endDateLabel.text!
            index = APBillDateWayViewBtnType.EndDateBtn
        }
        if (self.btnClickBlock != nil) {
            self.btnClickBlock!(currentTitle!,index!);
        }
    }
}
