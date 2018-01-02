//
//  APBillSettleWayView.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias ClickBtnBlock = (_ title: String) -> Void

class APBillSettleWayView: UIView {

    var titleBgView: UIView = UIView.init()
    var block: ClickBtnBlock?
    
    init(titleArray: [String]) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.init(hex6: 0x000000, alpha: 0.5)
        self.initCreatViews(titleArray: titleArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickBtnTypeAction(block: @escaping ClickBtnBlock) -> Void {
        self.block = block
    }
    
    func initCreatViews(titleArray: [String]){
        let bgView = UIView()
        self.titleBgView = bgView
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0)
        }
        if titleArray.count != 0 {
            for i in 0..<titleArray.count{
                let btn = UIButton()
                btn.setTitle(titleArray[i], for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                btn.setTitleColor(UIColor(hex6: 0x4c370b), for: .normal)
                btn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
                btn.tag = 100 + i
                bgView.addSubview(btn)
                btn.snp.makeConstraints({ (make) in
                    make.top.height.equalToSuperview()
                    make.width.equalToSuperview().dividedBy(titleArray.count)
                    make.left.equalTo(UIScreen.main.bounds.size.width/CGFloat(titleArray.count)*CGFloat(i))
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismAnimate()
    }
    
    @objc func btnAction(_ button: UIButton) {
        dismAnimate()
        if (self.block != nil) {
            self.block!((button.titleLabel?.text)!)
        }
    }
    
    private func dismAnimate() {
        self.titleBgView.snp.updateConstraints({ (make) in
            make.height.equalTo(0)
        })
        self.alpha = 1
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.layoutIfNeeded()
        }) { (complete) in
            if complete{
                self.isHidden = true
            }
        }
    }
    
}
