//
//  APRegisterToolBarView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRegisterToolBarView: UIView {
    
    var agreed: UIButton = UIButton()
    var agreement: UIButton = UIButton()

    init() {
        super.init(frame: CGRect.zero)
        
        agreed.titleLabel?.textAlignment = .left
        agreed.setTitle(_ : "我已阅读并接受", for: .normal)
        agreed.setTitleColor(_ : UIColor.black, for: .normal)
        
        agreement.titleLabel?.textAlignment = .right
        agreement.setTitle(_ : "《XXX用户协议》", for: .normal)
        agreement.setTitleColor(_ : UIColor.black, for: .normal)
        
        self.addSubview(agreed)
        self.addSubview(agreement)
        
        agreed.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        agreement.snp.makeConstraints { (maker) in
            maker.left.equalTo(agreed.snp.right)
            maker.centerY.equalTo(agreed.snp.centerY)
            maker.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
