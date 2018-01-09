//
//  APEarningHeadView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APEarningHeadView: UIView {

    var data : APGetProfitHomeResponse?{
        didSet{
            if Int((data?.profit)!) == 0 {
                moneyLabel.text = "0.00"
            }
            else{
                moneyLabel.text = data?.profit
            }
            yesterdayMoneyLabel.text = data?.yearsDayAmount
        }
    }
    
    weak var delegate : AP_TableViewDidSelectProtocol?
    
    let topLabel = UILabel()
    let moneyLabel = UILabel()
    let bottomLabel = UILabel()
    let yesterdayMoneyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage.init(named: "Earning_head_bg")
        let bgImageView = UIImageView.init(image: image?.cropped(to: -(1-64.0/204.0)))
       
        topLabel.text = "累计收益(元)"
        topLabel.font = UIFont.systemFont(ofSize: 12)
        topLabel.theme_textColor = ["#4c370b"]
        
        
        moneyLabel.text = "0.00"
        moneyLabel.font = UIFont.systemFont(ofSize: 42)
        moneyLabel.textAlignment = .left
        moneyLabel.theme_textColor = ["#7f5e12"]
        
       
        bottomLabel.text = "昨日收益(元)"
        bottomLabel.theme_textColor = ["#4c370b"]
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        
        
        yesterdayMoneyLabel.font = UIFont.systemFont(ofSize: 12)
        yesterdayMoneyLabel.theme_textColor = ["#4c370b"]
        yesterdayMoneyLabel.text = "+0.00"
        
        let arrowIcon = UIImageView.init(image: UIImage.init(named: "Mine_head_arrow"))
        
        addSubview(bgImageView)
        addSubview(topLabel)
        addSubview(moneyLabel)
        addSubview(bottomLabel)
        addSubview(yesterdayMoneyLabel)
        addSubview(arrowIcon)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.bottom.equalTo(0)
        }
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo((topLabel.superview?.snp.top)!).offset(13)
            make.left.equalTo(20)
            make.height.equalTo(15)
        }
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(7)
            make.left.equalTo(20)
            make.height.equalTo(44)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-23)
            make.left.equalTo(20)
        }
        yesterdayMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLabel.snp.right).offset(20)
            make.centerY.equalTo(bottomLabel.snp.centerY).offset(0)
        }
        arrowIcon.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.right.equalTo(-19)
            make.centerY.equalTo((arrowIcon.superview?.snp.centerY)!).offset(0)
        }
        
        let clickControl = UIControl()
        clickControl.addTarget(self, action: #selector(clickAction), for: UIControlEvents.touchUpInside)
        addSubview(clickControl)
        clickControl.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }

    @objc func clickAction()
    {
        delegate?.AP_Action_Click?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
