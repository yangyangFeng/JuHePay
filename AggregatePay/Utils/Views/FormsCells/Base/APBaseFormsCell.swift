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
    
    var identify: String = ""
    var predicate: NSPredicate?
    var textBlock: APFormsTextBlock?
    var buttonBlock: APFormsButtonBlock?
    
    func predicateInputRegx(inputRegx: String) {
        predicate = NSPredicate.init(format: "SELF MATCHES %@", inputRegx)
    }

    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func limitTextCount(text: NSString,
                        range: NSRange,
                        string: String) -> Bool {
        
        let returnText = text.replacingCharacters(in: range, with: string)
        var shouldReturn = true
        if string.count > 0 && string != "\n" {
            shouldReturn = (self.predicate?.evaluate(with: returnText))!
        }
        return shouldReturn
    }

}
