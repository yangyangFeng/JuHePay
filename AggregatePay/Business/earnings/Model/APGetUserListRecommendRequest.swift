//
//  APGetUserListRecommendRequest.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APGetUserListRecommendRequest: APBaseRequest {
    @objc dynamic var userId : String?
    @objc dynamic var type : String?
    @objc dynamic var levelId : String?
    
}

class APGetUserListRecommendResponse: APBaseResponse {
    
    @objc dynamic var list : [APGetUserListRecommendResponse]?
    @objc dynamic var registeDate : String?
    @objc dynamic var realName : String?
    @objc dynamic var mobileNo : String?
    @objc dynamic var levelId : String?
    @objc dynamic var authStatus : String?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : APGetUserListRecommendResponse.self]
    }
}
