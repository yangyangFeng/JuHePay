//
//  APQRCodeBaseViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 二维码收款父类
 * 接收首页模型传递的payType用于区分每个页面的标题和生成二维码的服务接口
 * 接收首页传递的金额
 */
class APQRCPBaseViewController: APBaseViewController {
    
    var payType: String?
    var amountStr: String?
    var payService: String?
    var qrCodePayRequest = APQRCodePayRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        switch payType! {
        case "wechatPay":
            self.title = "微信收款"
            payService = APHttpService.wechatPay
        case "aliPay":
            self.title = "支付宝收款"
            payService = APHttpService.aliPay
        default:
            self.title = "二维码收款"
            payService = ""
        }
    }
}
