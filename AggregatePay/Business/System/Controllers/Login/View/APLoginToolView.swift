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

    lazy var centerLine:UIImageView = {
        let view = UIImageView()
        view.theme_backgroundColor = ["#e6c893"]
        return view
    }()
    
    lazy var forget: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.setTitle(_ : "忘记密码", for: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .selected)
        view.addTarget(self, action: #selector(clickForgetButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    var register: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.setTitle(_ : "立即注册", for: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .normal)
        view.theme_setTitleColor(["#d09326"], forState: .selected)
        view.addTarget(self, action: #selector(clickRegisterButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
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
