//
//  EvaluateExtensions.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import Foundation

public extension String {
    
    enum APEvaluateRegx: String {
        case defalut  = ""
        case mobile   = "^1[3-9]\\d{9}$"
        case password = "^[a-zA-Z0-9-_]{6,16}$"
    }

    func evaluate(regx: APEvaluateRegx) -> Bool {
        if regx.rawValue == "" {
            return false
        }
        let predicate: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", regx.rawValue)
        return predicate.evaluate(with: self)
    }
    
}
