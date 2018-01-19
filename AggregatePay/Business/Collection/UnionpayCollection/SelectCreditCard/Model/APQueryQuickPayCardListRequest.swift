//
//  APQueryQuickPayCardListRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

/** get
 * 获取绑定成功的银联快捷卡列表
 */
class APQueryQuickPayCardListRequest: APBaseRequest {

    //当前页数
    @objc dynamic var pageNo: Int = 1
    
    //每页展示的条数
    @objc dynamic let pageSize: Int = 10
    
}
