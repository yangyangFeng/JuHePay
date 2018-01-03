//
//  APSearchBankResponse.swift
//  AggregatePay
//
//  Created by 沈陈 on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APSearchBankResponse: APBaseResponse {
    @objc dynamic var coCnapsRespList: [APBank]?
    
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["coCnapsRespList" : APBank.self]
    }

}
