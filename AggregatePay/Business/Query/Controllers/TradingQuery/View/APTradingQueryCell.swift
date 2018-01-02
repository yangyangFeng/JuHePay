//
//  APTradingQueryCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/29.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APTradingQueryCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        initCreatViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func displayGetMyAccountDetail(detail: APGetMyAccountDetail) {
        amountLabel.text = detail.transAmount
        useLabel.text = detail.transType
        timeLabel.text = detail.transDate
        if detail.payModel == "1" {
            typeLabel.text = "微信"
            iconImageView.image = UIImage(named: "Bill_WeChat")
        }
        else if detail.payModel == "2" {
            typeLabel.text = "支付宝"
            iconImageView.image = UIImage(named: "Bill_Zfb")
        }
        else {
            typeLabel.text = "银联快捷"
            iconImageView.image = UIImage(named: "Bill_UnionPay")
        }
    }
    

    //MARK: ---- lazy loading
    
    lazy var bottom_line: UIImageView = {
        let view = UIImageView()
        view.theme_backgroundColor = [AP_TableViewBackgroundColor]
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Bill_WeChat")
        return view
    }()
    
    lazy var helpImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Mine_head_arrow")
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.text = "11,000.00"
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.init(hex6: 0x484848)
        view.textAlignment = NSTextAlignment.right
        return view
    }()
    lazy var useLabel: UILabel = {
        let view = UILabel()
        view.text = "消费"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.init(hex6: 0x9c9b99)
        view.textAlignment = NSTextAlignment.right
        return view
    }()
    
    lazy var typeLabel: UILabel = {
        let view = UILabel()
        view.text = "微信"
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.init(hex6: 0x484848)
        view.textAlignment = NSTextAlignment.left
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.text = "注册时间:2017/11/12 11:21:11"
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.init(hex6: 0x9c9b99)
        view.textAlignment = NSTextAlignment.left
        return view
    }()
}

extension APTradingQueryCell {
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APTradingQueryCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        guard let newCell = cell else {
            cell = UITableViewCell(style: UITableViewCellStyle.default,
                                   reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    func initCreatViews(){
        addSubview(bottom_line)
        addSubview(iconImageView)
        addSubview(helpImageView)
        addSubview(amountLabel)
        addSubview(useLabel)
        addSubview(typeLabel)
        addSubview(timeLabel)
        
        bottom_line.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self)
            make.height.equalTo(2)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(bottom_line.snp.left)
            make.centerY.equalToSuperview()
            make.height.equalTo((iconImageView.image?.size.height)!)
            make.width.equalTo((iconImageView.image?.size.width)!)
        }
        helpImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo((helpImageView.image?.size.height)!)
            make.width.equalTo((helpImageView.image?.size.width)!)
            make.right.equalTo(bottom_line.snp.right)
        }
        amountLabel.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.top.equalTo(10)
            make.right.equalTo(helpImageView.snp.left).offset(-5)
            make.left.equalTo(self.snp.centerX)
        }
        
        useLabel.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.top.equalTo(amountLabel.snp.bottom)
            make.right.equalTo(amountLabel.snp.right)
            make.width.equalTo(30)
        }
        
        typeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.top.equalTo(amountLabel.snp.top)
            make.right.equalTo(self.snp.centerX)
            make.left.equalTo(iconImageView.snp.right).offset(11)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.top.equalTo(amountLabel.snp.bottom)
            make.right.equalTo(useLabel.snp.left)
            make.left.equalTo(typeLabel)
        }
    }
}






