//
//  APEarningsHttpTool.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

extension APHttpService{
    static let getProfitHome: String = "/query/getProfitHome"//收益收益
    static let getUserListRecommend: String = "/query/getUserListRecommend" //2.获取用户间接/直接推广客户列表
    static let getMyProfit: String = "/query/getMyProfit"

}

class APEarningsHttpTool: NSObject {
    static func getProfitHome(_ params : APBaseRequest, success : @escaping APNetWorkingSuccessBlock,faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.getProfitHome, params: params, aClass: APGetProfitHomeResponse.self, success: success, failure: faile)
    }
    static func getUserListRecommend(_ params : APBaseRequest, success : @escaping APNetWorkingSuccessBlock,faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.getUserListRecommend, params: params, aClass: APGetUserListRecommendResponse.self, success: success, failure: faile)

    }
    static func getMyProfit(_ params : APBaseRequest, success : @escaping APNetWorkingSuccessBlock,faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.getMyProfit, params: params, aClass: APGetMyProfitResponse.self, success: success, failure: faile)

    }
}
