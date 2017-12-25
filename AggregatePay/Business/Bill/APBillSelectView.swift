//
//  APBillSelectView.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias btnActionBlock = (_ index: Int) -> Void

protocol APBillSelectViewDelegate: NSObjectProtocol {
    func clickSelectBtn(index: Int) 
}

class APBillSelectView: UIView {
    
    var titleArray: [String]
    private let lineView = UIView()
    private var previousBtn = UIButton()
    var delegate: APBillSelectViewDelegate?
    var btnBlock: btnActionBlock?
    
    func clickBtnBlock(block: @escaping btnActionBlock){
        self.btnBlock = block
    }
    
    func setBtnIndex(index: Int){
        if (index >= 0) && (index <= 3){
            let currentBtn = self.viewWithTag(index+100) as? UIButton
            self.titleAnimate(button: currentBtn!)
        }
        else{
            fatalError("传入的index只能0-3的整数")
        }
    }
    
    init(titleArray: [String]) {
        self.titleArray = titleArray
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor(hex6: 0xf5f5f5)
        self.initCreatView(titleArray: titleArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCreatView(titleArray: [String]){
        for i in 0..<titleArray.count {
            let btn = UIButton()
            btn.setTitle(titleArray[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor(hex6: 0x999999), for: .normal)
            btn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
            btn.tag = 100 + i
            self.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.top.height.equalTo(self)
                make.width.equalToSuperview().dividedBy(titleArray.count)
                make.left.equalTo(UIScreen.main.bounds.size.width/CGFloat(titleArray.count)*CGFloat(i))
            })
            
            if i == 0{
                self.previousBtn = btn;
                btn.setTitleColor(UIColor(hex6: 0xc8a556), for: .normal)
                self.lineView.backgroundColor = UIColor(hex6: 0xc8a556)
                self.addSubview(self.lineView)
                self.lineView.snp.makeConstraints({ (make) in
                    make.left.bottom.equalToSuperview()
                    make.height.equalTo(2)
                    make.width.equalToSuperview().dividedBy(titleArray.count)
                })
            }
        }
    }
    
    @objc func btnAction(_ button: UIButton) {
        self.titleAnimate(button: button)
        self.delegate?.clickSelectBtn(index: button.tag - 100)
        if (self.btnBlock != nil) {
            self.btnBlock!(button.tag - 100)
        }
    }
    
    func titleAnimate(button: UIButton) -> Void {
        UIView.animate(withDuration: 0.25) {
            self.previousBtn.setTitleColor(UIColor(hex6: 0x999999), for: .normal)
            button.setTitleColor(UIColor(hex6: 0xc8a556), for: .normal)
            self.lineView.snp.remakeConstraints { (make) in
                make.left.equalTo(button)
                make.bottom.equalToSuperview()
                make.height.equalTo(2)
                make.width.equalToSuperview().dividedBy(self.titleArray.count)
            }
            self.lineView.layoutIfNeeded()
        }
        self.previousBtn = button
    }
}
