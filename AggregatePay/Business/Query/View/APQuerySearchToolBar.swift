//
//  APQuerySearchToolBar.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APQuerySearchToolBar: UIView {
    
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        
        addSubview(payWayView)
        addSubview(payTypeView)
        addSubview(contentView)
        
        payWayView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
        }
        payTypeView.snp.makeConstraints { (make) in
            make.left.equalTo(payWayView.snp.right).offset(5)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func payWayAction() {
        
    }
    
    @objc func payTypeAction() {
        
    }
    
    //MARK: ---- lazy loading
    
    lazy var payWayView: APQuerySearchButton = {
        let view = APQuerySearchButton()
        view.titleLabel.text = "收款方式:"
        view.textLabel.text = "全部"
        view.button.addTarget(self, action: #selector(payWayAction), for: .touchUpInside)
        return view
    }()
    
    lazy var payTypeView: APQuerySearchButton = {
        let view = APQuerySearchButton()
        view.titleLabel.text = "结算方式:"
        view.textLabel.text = "D+0"
        view.button.addTarget(self, action: #selector(payTypeAction), for: .touchUpInside)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
}

class APQuerySearchButton: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(arrowIamgeView)
        addSubview(button)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        textLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        arrowIamgeView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(textLabel.snp.right)
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        button.snp.makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ---- lazy loading
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.clear
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#4c370b"]
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#4c370b"]
        view.backgroundColor = UIColor.white
        view.text = "银联快捷收款"
        return view
    }()
    
    lazy var arrowIamgeView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named:"Bill_Arrow_Default")
        view.backgroundColor = UIColor.white
        return view
    }()
    
}






