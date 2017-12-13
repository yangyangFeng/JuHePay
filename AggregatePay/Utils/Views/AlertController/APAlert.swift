//
//  APAlert.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAlert: NSObject {
    
    static func show(message: String,
                     confirmTitle: String,
                     canceTitle: String,
                     confirm:@escaping (UIAlertAction) -> Void,
                     cancel:@escaping (UIAlertAction) -> Void) {
        
        let alertController = APAlertController(title: "提示",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: canceTitle, style: .cancel) { (action) in
            cancel(action)
        }
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirm(action)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        alertController.show()
    }

}
