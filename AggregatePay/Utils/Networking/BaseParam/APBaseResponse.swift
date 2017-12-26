//
//  APBaseResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseResponse: NSObject {
    
    @objc dynamic var respCode: String?
    @objc dynamic var respMsg: String?
    @objc dynamic var respTime: String?
    @objc dynamic var isSuccess: String?
   
}
