//
//  APPayEssentialToolBarView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APPayEssentialSelectCreditCardBlock = (_ param: Any) -> Void

/**
 * 输入支付要素子视图（选择信用卡cell）
 */
class APPayEssentialToolBarView: APBaseFormsCell {

    var selectCreditCardBlock: APPayEssentialSelectCreditCardBlock?
    
    lazy var creditCardTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13)
        view.theme_textColor = ["#9c9b99"]
        view.textAlignment = .left
        view.text = "信用卡信息"
        return view
    }()
    
    var selectCreditCardButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.setTitle(_ : "选择信用卡", for: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .selected)
        view.addTarget(self, action: #selector(clickSelectCreditCardButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    override init() {
        
        super.init()
        
        backgroundColor = UIColor.clear
        
        self.addSubview(creditCardTitleLabel)
        self.addSubview(selectCreditCardButton)
       
        creditCardTitleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(self.snp.height)
        }
        
        selectCreditCardButton.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right).offset(-20)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(self.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func clickSelectCreditCardButton(_ button: UIButton) {
        selectCreditCardBlock?(button)
    }
    

}
