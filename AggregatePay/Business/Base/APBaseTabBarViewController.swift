//
//  APBaseTabBarViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

import ESTabBarController_swift

class APBaseTabBarViewController: ESTabBarController {
    
    var isValidationUserIdentityStatus: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTabBarCallBack()
        let TopLine = UIView()
        TopLine.backgroundColor = UIColor(hex6: 0x323232)
        tabBar.addSubview(TopLine)
        
        TopLine.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
    
    func didTabBarCallBack() {
        
        self.shouldHijackHandler = { tabbarController, viewController, index in
            if (index == 0 && self.isValidationUserIdentityStatus) ||
               (index == 3 && self.isValidationUserIdentityStatus) ||
               (index == 2 ||
                index == 4) {
                self.isValidationUserIdentityStatus = false
                return false
            }
            return true
        }
        
        self.didHijackHandler = { tabbarController, viewController, index in
            let baseNav = viewController as! APBaseNavigationViewController
            let baseVC = baseNav.childViewControllers.first as! APBaseViewController
            if index == 0 || index == 3 {
                baseVC.ap_userIdentityStatus({ (status) in
                    self.isValidationUserIdentityStatus = true
                    tabbarController.selectedIndex = index
                })
            }
            
            if index == 1 {
                tabbarController.selectedIndex = 2
                let homeController : UINavigationController = tabbarController.viewControllers![2] as! UINavigationController
                homeController.pushViewController(APPromoteViewController())
            }
            
        }
    }
    
}
