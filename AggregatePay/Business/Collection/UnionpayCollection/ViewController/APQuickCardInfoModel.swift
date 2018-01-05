//
//  APQuickCardInfoModel.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APQuickCardInfoModel: NSObject {
    //持卡人姓名
    @objc dynamic var realName: String = ""
    
    //卡号
    @objc dynamic var cardNo: String = ""
    
    //银行预留手机号
    @objc dynamic var reserveMobileNo: String  = ""
    
    //cvn
    @objc dynamic var cvn: String = ""
    
    //有效期YYMM格式（贷记卡必选）
    @objc dynamic var expireDate: String = ""
    
    //是否积分交易 0：非积分 1：积分
    @objc dynamic var integraFlag: String?
    
}
