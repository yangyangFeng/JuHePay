//
//  APBillDetailCollectionViewCell.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBillDetailCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCreatViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCreatViews(){
        
        let tableView = UITableView(frame: CGRect.zero,style: UITableViewStyle.plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self;
        tableView.dataSource = self;
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "APBillTradeDetailTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = APBillTradeDetailTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        return cell!
    }
    
}

class APBillTradeDetailTableViewCell: UITableViewCell {
    
    var amountLabel = UILabel()
    var useLabel = UILabel()
    var typeLabel = UILabel()
    var timeLabel = UILabel()
    var iconImageView = UIImageView()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCreatViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCreatViews(){
        let iconImageView = UIImageView.init(image: UIImage(named: "Bill_WeChat"))
        self.iconImageView = iconImageView
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo((iconImageView.image?.size.height)!)
            make.width.equalTo((iconImageView.image?.size.width)!)
        }
        
        let helpImageView = UIImageView.init(image: UIImage.init(named: "Mine_head_arrow"))
        self.addSubview(helpImageView)
        helpImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo((helpImageView.image?.size.height)!)
            make.width.equalTo((helpImageView.image?.size.width)!)
            make.right.equalToSuperview().offset(-20)
        }
        
        let amountLabel = UILabel()
        self.amountLabel = amountLabel
        amountLabel.text = "11,000.00"
        amountLabel.font = UIFont.systemFont(ofSize: 14)
        amountLabel.textColor = UIColor.init(hex6: 0x484848)
        amountLabel.textAlignment = NSTextAlignment.right
        self.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.top.equalTo(10)
            make.right.equalTo(helpImageView.snp.left).offset(-5)
            make.left.equalTo(self.snp.centerX)
        }
        
        let useLabel = UILabel()
        self.useLabel = useLabel
        useLabel.text = "消费"
        useLabel.font = UIFont.systemFont(ofSize: 12)
        useLabel.textColor = UIColor.init(hex6: 0x9c9b99)
        useLabel.textAlignment = NSTextAlignment.right
        self.addSubview(useLabel)
        useLabel.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.top.equalTo(amountLabel.snp.bottom)
            make.right.equalTo(amountLabel.snp.right)
            make.width.equalTo(30)
        }
        
        let typeLabel = UILabel()
        self.typeLabel = typeLabel
        typeLabel.text = "微信"
        typeLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.textColor = UIColor.init(hex6: 0x484848)
        typeLabel.textAlignment = NSTextAlignment.left
        self.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.top.equalTo(amountLabel.snp.top)
            make.right.equalTo(self.snp.centerX)
            make.left.equalTo(iconImageView.snp.right).offset(11)
        }
        
        let timeLabel = UILabel()
        self.timeLabel = timeLabel
        timeLabel.text = "注册时间:2017/11/12 11:21:11"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.init(hex6: 0x9c9b99)
        timeLabel.textAlignment = NSTextAlignment.left
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.top.equalTo(amountLabel.snp.bottom)
            make.right.equalTo(useLabel.snp.left)
            make.left.equalTo(typeLabel)
        }
    }
}

