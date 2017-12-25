//
//  APQRCodeTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import EFQRCode

typealias APQRCodeSuccessBlock = (_ image: UIImage) -> Void
typealias APQRCodeFailureBlock = (_ error: String) -> Void

class APQRCodeTool: NSObject {

    static func AP_QRCode(content: String,
                          success: APQRCodeSuccessBlock,
                          failure: APQRCodeFailureBlock) {
        if let tryImage = EFQRCode.generate(content: content) {
            success(UIImage(cgImage: tryImage))
        }
        else {
            failure("生成失败")
        }
    }
    
}
