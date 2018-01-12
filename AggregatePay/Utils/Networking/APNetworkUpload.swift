//
//  APNetworkUpload.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/12.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APNetworkUpload: APNetworkUtil {
    
    public static let sharedInstance: APNetworkUpload = {
        let networkRequest = APNetworkUpload()
        networkRequest.ap_careatesessionManager(timeoutIntervalForRequest: 30)
        return networkRequest
    }()

}
