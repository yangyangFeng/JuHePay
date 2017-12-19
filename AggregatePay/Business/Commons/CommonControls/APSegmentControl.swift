//
//  APSegmentControl.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias AP_SegmentBlock = (_ index : Int)->Void

class APSegmentControl: UIView {
    
    let bottomLine = UIView()
    
    /// 回调block
    var segmentBlock : AP_SegmentBlock?
    
    /// 重复点击是否触发回调
    var repeatClick = false
    
    private var lastIndex : Int = 0
    
    
    private var titleArray : [String]!
    
    
    convenience init(_ titles : [String] , frame : CGRect) {
        self.init(frame: frame)
        self.titleArray = titles
        bottomLine.theme_backgroundColor = ["#c8a556"]
        let itemWidth : CGFloat = self.width/CGFloat(titles.count)
        for i in 0..<titles.count
        {
            let button = UIButton(type: .custom)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.theme_setTitleColor(["#c8a556"], forState: .selected)
            button.theme_setTitleColor(["#c8a556"], forState: .highlighted)
            button.theme_setTitleColor(["#999999"], forState: .normal)
            button.setTitle(titles[i], for: UIControlState.normal)
            button.theme_backgroundColor = ["#373737"]
            button.tag = i
            button.addTarget(self, action: #selector(buttonDidAction), for: UIControlEvents.touchUpInside)
            
            addSubview(button)
            
            
            button.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(0)
                make.left.equalTo(itemWidth*CGFloat(i))
                make.width.equalTo(itemWidth)
            })
        }
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.equalTo(0)
            make.height.equalTo(2)
            make.width.equalTo(snp.width).multipliedBy(1.0/CGFloat(titles.count))
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = ["#373737"]
    }
    
    @objc func buttonDidAction(_ button : UIButton)
    {
        for view in self.subviews {
            if let btn = view as? UIButton
            {
                btn.isSelected = btn == button ? true : false
            }
        }
        
        if repeatClick {
            segmentBlock?(button.tag)
        }
        else if !repeatClick && lastIndex != button.tag{
            segmentBlock?(button.tag)
        }
        
        let itemWidth : CGFloat = self.width/CGFloat(titleArray.count)
        UIView.animate(withDuration: 0.15, animations: {
            self.bottomLine.snp.updateConstraints({ (make) in
                make.left.equalTo(itemWidth * CGFloat(button.tag))
            })
            self.layoutIfNeeded()
            
        }, completion: { (state) in
            
        })
        
        lastIndex = button.tag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
