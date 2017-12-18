//
//  APBaseFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APFormsTextBlock = (_ key: String,_ value: String) -> Void
typealias APFormsButtonBlock = (_ key: String,_ value: Any) -> Void

class APBaseFormsCell: UIView {
    
   
    lazy var topLine: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var bottomLine: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private var predicate: NSPredicate?
    var buttonBlock: APFormsButtonBlock?
    var textBlock: APFormsTextBlock?
    var identify: String = ""
    var inputRegx: String = "" {
        willSet{
            predicate = NSPredicate.init(format: "SELF MATCHES %@", newValue)
        }
    }
   
    init() {
        super.init(frame: CGRect.zero)
        
        
        topLine.backgroundColor = UIColor.clear
        bottomLine.theme_backgroundColor = ["#f4f4f4"]
        

        addSubview(topLine)
        addSubview(bottomLine)
        
        topLine.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(self.snp.top)
            maker.height.equalTo(1)
        }
        
        bottomLine.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.bottom)
            maker.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 验证正则表达式的公共方法
     */
    func limitTextCount(text: NSString,
                        range: NSRange,
                        string: String) -> Bool {
        var shouldReturn = true
        if predicate == nil {
            return shouldReturn
        }
        let returnText = text.replacingCharacters(in: range, with: string)
        if string.characters.count > 0 && string != "\n" {
            shouldReturn = (self.predicate?.evaluate(with: returnText))!
        }
        return shouldReturn
    }

}
