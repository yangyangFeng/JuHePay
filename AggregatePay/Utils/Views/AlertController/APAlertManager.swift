//
//  APAlert.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAlertManager: NSObject {

    static func show(param: @escaping (APAlertParam) -> Void,
                     confirm: @escaping (UIAlertAction) -> Void,
                     cancel: ((UIAlertAction) -> Void)? = nil) {
        
        let alertParam = APAlertParam()
        param(alertParam)
        let alertController = APAlertController(title: "提示",
                                                message: alertParam.apMessage,
                                                preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: alertParam.apConfirmTitle,
                                          style: .default)
        { (action) in
            confirm(action)
        }
        alertController.addAction(confirmAction)
        
        if cancel != nil {
            let cancelAction = UIAlertAction(title: alertParam.apCanceTitle,
                                             style: .cancel)
            { (action) in
                cancel?(action)
            }
            alertController.addAction(cancelAction)
        }
        alertController.show()
    }

}


class APAlertParam: NSObject {
    var apMessage: String?
    var apCanceTitle: String?
    var apConfirmTitle: String?
}
