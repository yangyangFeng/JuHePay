//
//  APSystemResultVC.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

extension APBaseViewController {
    
    func forgetSuccessShow(block: @escaping APSystemSuccessBlock) {
        let vc = APSystemSuccessViewController()
        vc.show(image: "sys_forget_success_icon") {
            block()
            vc.dismiss(animated: true, completion: nil)
            
        }
        let navigation = APBaseNavigationViewController(rootViewController: vc)
        self.present(navigation, animated: true)
    }
    
    func registerSuccessShow(block: @escaping APSystemSuccessBlock) {
        let vc = APSystemSuccessViewController()
        vc.show(image: "sys_register_success") {
            block()
            vc.dismiss(animated: true, completion: nil)
        }
        let navigation = APBaseNavigationViewController(rootViewController: vc)
        self.present(navigation, animated: true)
    }
    
    func modifySuccessShow(block: @escaping APModifySuccessBlock) {
        APModifySuccessViewController().show(block: block)
    }
}
