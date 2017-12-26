//
//  APOCRBankCard.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/22.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APOCRBankCard: NSObject {
    
    /// 银行名字
    var bankName: String?
    
    /// 卡名
    var cardName: String?
    
    /// 卡类型
    var cardType: String?
    
    /// 卡号
    var cardNum: String?
    
    /// 有效期
    var validDate: String?
    
    /// 银行卡照片
    var bankCardImage: UIImage?
    
    /// 组织机构代码
    var bankOrgcode: String?
    
}
