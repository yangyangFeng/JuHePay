//
//  APEarningsHttpTool.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APEarningsHttpTool: NSObject {
    static func getProfitHome(_ params : APBaseRequest, success : @escaping APNetWorkingSuccessBlock,faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: .manange_httpUrl, action: .getProfitHome, params: params, aClass: APBaseResponse.self, success: success, faile: faile)
    }
    static func getUserListRecommend(_ params : APBaseRequest, success : @escaping APNetWorkingSuccessBlock,faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: .manange_httpUrl, action: .getUserListRecommend , params: params, aClass: APBaseResponse.self, success: success, faile: faile)
    }
    static func getMyProfit(_ params : APBaseRequest, success : @escaping APNetWorkingSuccessBlock,faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: .manange_httpUrl, action: .getMyProfit, params: params, aClass: APBaseResponse.self, success: success, faile: faile)
    }
}
