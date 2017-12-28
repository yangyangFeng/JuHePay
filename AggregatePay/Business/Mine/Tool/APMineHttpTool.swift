//
//  APMineHttpTool.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

extension APHttpService{
    static let userInfo:String    = "/user/getUserInfo" //用户信息
    static let getCardListByUserId: String = "/user/getCardListByUserId" //获取银行卡
    static let aboutInfo: String = "/user/getAboutUsInfo" //关于我们
}

extension APHttpUrl{
    static let test_url:String = "http://192.168.4.111:47800"
}

class APMineHttpTool: NSObject {
    
    /// 获取银行卡列表
    ///
    static func getBankList(_ param : APBaseRequest,
                            success : @escaping APNetWorkingSuccessBlock,
                            faile : @escaping APNetWorkingFaileBlock){
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.getCardListByUserId, params: param, aClass: APCardListResponse.self, success: success, failure: faile)
    }
    
    /// 获取用户信息
    ///
    static func getUserInfo(_ param : APBaseRequest,
                            success : @escaping APNetWorkingSuccessBlock,
                            faile : @escaping APNetWorkingFaileBlock){
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.userInfo, params: param, aClass: APUserInfoResponse.self.self, success: success, failure: faile)
    }
    /// 获取APP信息
    ///
    static func aboutInfo(_ param : APBaseRequest,
                            success : @escaping APNetWorkingSuccessBlock,
                            faile : @escaping APNetWorkingFaileBlock){
        APNetworking.get(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.aboutInfo, params: param, aClass: APAboutUsResponse.self.self, success: success, failure: faile)
    }
}
