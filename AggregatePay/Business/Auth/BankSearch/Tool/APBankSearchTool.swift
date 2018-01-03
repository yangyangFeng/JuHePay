//
//  APBankSearchTool.swift
//  AggregatePay
//
//  Created by 沈陈 on 2018/1/2.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APBankSearchTool: NSObject {
    static func queryCnapsListByBankName(params: APSearchBankRequest,
                                         success: @escaping (APSearchBankResponse) -> Void,
                                         failure: @escaping (APBaseError)-> Void)
    {
        APNetworking.post(httpUrl: APHttpUrl.manange_httpUrl, action: APHttpService.searchBank, params: params, aClass: APSearchBankResponse.self, success: { (response) in
            success(response as! APSearchBankResponse)
        }) { (error) in
            failure(error)
        }
    }
}
