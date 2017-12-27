//
//  APMineHttpTool.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APMineHttpTool: NSObject {
    
    /// 获取银行卡列表
    ///
    static func getBankList(_ param : APBaseRequest,
                            success : @escaping APNetWorkingSuccessBlock,
                            faile : @escaping APNetWorkingFaileBlock){
        APNetworking.post(httpUrl: .test_url, action: .getCardListByUserId, params: param, aClass: APCardListResponse.self, success: { (response) in
            print(response)
            success(response)
        }) { (error) in
            print(error)
            faile(error)
        }
    }
    
    /// 获取银行卡列表
    ///
    static func getUserInfo(_ param : APBaseRequest,
                            success : @escaping APNetWorkingSuccessBlock,
                            faile : @escaping APNetWorkingFaileBlock){
        APNetworking.post(httpUrl: .test_url, action: .userInfo, params: param, aClass: APUserInfoResponse.self, success: { (response) in
            print(response)
            success(response)
        }) { (error) in
            print(error)
            faile(error)
        }
    }
}
