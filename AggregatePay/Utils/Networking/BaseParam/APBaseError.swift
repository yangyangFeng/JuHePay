//
//  APBaseError.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseError: NSObject, Error {

    @objc dynamic var status: String?
    @objc dynamic var message: String?

}
