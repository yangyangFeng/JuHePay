//
//  APLoginToolView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APLoginToolViewGotoRegisterButtonBlock = (_ param: Any) -> Void
typealias APLoginToolViewGoToForgetButtonBlock = (_ param: Any) -> Void

class APLoginToolView: UIView {
    
    var gotoRegisterBlock: APLoginToolViewGotoRegisterButtonBlock?
    var gotoForgetBlock: APLoginToolViewGoToForgetButtonBlock?

    var centerLine:UIImageView = UIImageView()
    var forget: UIButton = UIButton()
    var register: UIButton = UIButton()
    
    init() {
        super.init(frame: CGRect.zero)
        
        centerLine.theme_backgroundColor = ["#e6c893"]
        
        forget.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        forget.setTitle(_ : "忘记密码", for: .normal)
        
        forget.theme_setTitleColor(["#d09326"], forState: .normal)
        forget.theme_setTitleColor(["#d09326"], forState: .selected)
        forget.addTarget(self,
                         action: #selector(clickForgetButton(_:)),
                         for: UIControlEvents.touchUpInside)
        
        register.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        register.setTitle(_ : "立即注册", for: .normal)
        register.theme_setTitleColor(["#d09326"], forState: .normal)
        register.theme_setTitleColor(["#d09326"], forState: .selected)
        register.addTarget(self,
                           action: #selector(clickRegisterButton(_:)),
                           for: UIControlEvents.touchUpInside)
        
        self.addSubview(centerLine)
        self.addSubview(forget)
        self.addSubview(register)
        
        centerLine.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(self.snp.centerX)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.width.equalTo(1)
        }
        
        forget.snp.makeConstraints { (maker) in
            maker.right.equalTo(centerLine.snp.left).offset(-10)
            maker.centerY.equalTo(centerLine.snp.centerY)
            maker.height.equalTo(self.snp.height)
        }
        
        register.snp.makeConstraints { (maker) in
            maker.left.equalTo(centerLine.snp.right).offset(10)
            maker.centerY.equalTo(centerLine.snp.centerY)
            maker.height.equalTo(centerLine.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickForgetButton(_ button: UIButton) {
        gotoForgetBlock?(button)
    }
    
    @objc func clickRegisterButton(_ button: UIButton) {
        gotoRegisterBlock?(button)
    }
    

}
