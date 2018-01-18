//
//  APCheckAppVerisonRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/5.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APCheckAppVerisonRequest: APBaseRequest {
    @objc dynamic var systemType : String?
}

class APCheckAppVerisonResponse: APBaseResponse {
    
    @objc dynamic var lastVersionContent : String = ""
    @objc dynamic var lastVersionCreateDate : String = ""
    @objc dynamic var lastVersionDownloadUrl : String = ""
    @objc dynamic var systemType : String = ""
    @objc dynamic var minVersionNo: String = ""
    @objc dynamic var lastVersionNo : String = ""
}
