//
//  APGetOnlineTransResultResponse.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/28.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码收款结果响应报文模型
 */
class APGetOnlineTransResultResponse: APBaseResponse {
    /**
     
     TRANS_UNKNOWN("交易未知", "0"),
     TRANS_PROCESS("交易处理中", "1"),
     TRANS_SUCESS("交易成功", "2"),
     TRANS_FIAL("交易失败", "3"),
     TRANS_CLOSED("交易关闭", "4"),
     TRANS_CANEL("交易撤销", "5"),
     TRANS_REFUND("交易退款", "6");
     */
    
    @objc dynamic var orderNo: String?
    @objc dynamic var payServiceCode: String?
    @objc dynamic var status: String?
    @objc dynamic var transAmount: String?
    @objc dynamic var transDateTime: String?
    @objc dynamic var respDesc: String?

}
