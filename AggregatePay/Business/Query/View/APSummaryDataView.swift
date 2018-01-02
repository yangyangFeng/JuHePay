//
//  APSummaryDataView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APSummaryDataView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        
        addSubview(verticalLine)
        addSubview(leftBottomView)
        addSubview(rightBottomView)
        
        verticalLine.snp.makeConstraints { (make) in
            make.width.equalTo(2.5)
            make.centerX.equalTo(snp.centerX).offset(0)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
        }
        
        leftBottomView.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.top.bottom.equalTo(self)
            make.right.equalTo(verticalLine.snp.left).offset(0)
        }
        rightBottomView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(0)
            make.top.bottom.equalTo(self)
            make.left.equalTo(verticalLine.snp.right).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var verticalLine : UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "ReturnSearchVerticalLine"))
        return view
    }()
    
    lazy var leftBottomView : APSummaryDataItemView = {
        let view = APSummaryDataItemView()
        view.iconImageView.image = UIImage.init(named: "Earnings_numer_icon")
        view.topTitle.text = "交易笔数"
        view.title.text = "0"
        return view
    }()
    
    lazy var rightBottomView : APSummaryDataItemView = {
        let view = APSummaryDataItemView()
        view.iconImageView.image = UIImage.init(named: "Earnings_sum_icon")
        view.topTitle.text = "交易总额"
        view.title.text = "0.0"
        return view
    }()

}

class APSummaryDataItemView: UIView {
    
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
