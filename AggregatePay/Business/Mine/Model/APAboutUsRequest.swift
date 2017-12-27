//
//  APAboutUsRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAboutUsRequest: APBaseRequest {
    /// 1.iOS
    @objc dynamic var systemType:String = "1"
}

class APAboutUsResponse: APBaseResponse {
    /// 服务热线
    @objc dynamic var serviceHotline : String?
    /// 官网地址
    @objc dynamic var officialWebsiteAddress : String?
}
