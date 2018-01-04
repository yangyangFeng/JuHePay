//
//  APTransMsgRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/3.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APTransMsgRequest: APBaseRequest {
    //持卡人姓名
    @objc dynamic var realName: String?
    //卡号
    @objc dynamic var cardNo: String?
    //银行预留手机号
    @objc dynamic var reserveMobileNo: String?
    //是否积分交易 0：非积分 1：积分
    @objc dynamic var integraFlag: String?
    //交易金额-单位分
    @objc dynamic var amount: String?
}
