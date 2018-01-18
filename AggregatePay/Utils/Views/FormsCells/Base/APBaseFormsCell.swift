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
    
    enum APInputRegx: String {
        case defalut = ""
        case mobile = "^1[0-9]{0,10}$"
        case password = "^[A-Za-z0-9-_]{0,16}$"
        case smsCode = "^[0-9]{0,4}$"
        case quickSmsCode = "^[0-9]{0,6}$"
        case inviteCode = "^[A-Za-z0-9-_]{0,6}$"
        case cvn2 = "^[0-9]{0,3}$"
        case bankCard = "^\\d{0,21}$"
        case idCardNo = "^\\w{0,18}$"
        case name = "[a-zA-Z\u{4e00}-\u{9fa5}}][a-zA-Z0-9\u{4e00}}-\u{9fa5}}]+"
    }


    
    

   
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
    var inputRegx: APInputRegx = .defalut {
        willSet{
            predicate = NSPredicate.init(format: "SELF MATCHES %@", newValue.rawValue)
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
            maker.height.equalTo(0.5)
        }
        
        bottomLine.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.bottom)
            maker.height.equalTo(0.5)
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
        if inputRegx == .name{
            if string == "，"{
                return true
            }
            if string == "➋"{
                return true
            }
            if string == "➌"{
                return true
            }
            if string == "➍"{
                return true
            }
            if string == "➎"{
                return true
            }
            if string == "➏"{
                return true
            }
            if string == "➐"{
                return true
            }
            if string == "➑"{
                return true
            }
            if string == "➒"{
                return true
            }
        }
        if string.count > 0 && string != "\n" {
            shouldReturn = (self.predicate?.evaluate(with: returnText))!
        }
        return shouldReturn
    }

}
