//
//  APLoginToolBarView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

protocol APLoginToolBarViewDelegate: NSObjectProtocol {
    func onDidMemory();
    func onDidForget();
}

class APLoginToolBarView: UIView {
    
    var delegate: APLoginToolBarViewDelegate?
    
    var memory: UIButton = UIButton()
    var forget: UIButton = UIButton()
    
    init() {
        super.init(frame: CGRect.zero)
        
        memory.titleLabel?.textAlignment = .left
        memory.setTitle(_ : "记住密码", for: .normal)
        memory.setTitleColor(_ : UIColor.black, for: .normal)
        memory.addTarget(self,
                         action: #selector(clickMemory),
                         for: .touchUpInside)
        
        forget.titleLabel?.textAlignment = .right
        forget.setTitle(_ : "忘记密码?", for: .normal)
        forget.setTitleColor(_ : UIColor.black, for: .normal)
        forget.addTarget(self,
                         action: #selector(clickForget),
                         for: .touchUpInside)
        
        self.addSubview(memory)
        self.addSubview(forget)
        
        memory.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(self.snp.height).multipliedBy(0.5)
            maker.width.equalTo(100)
        }
        
        forget.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.centerY.equalTo(self.snp.centerY)
            maker.height.equalTo(self.snp.height).multipliedBy(0.5)
            maker.width.equalTo(100)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickMemory() {
        delegate?.onDidMemory()
    }
    @objc func clickForget() {
        delegate?.onDidForget()
    }
    
}
