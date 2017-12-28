//
//  APBaseNavigationViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseNavigationViewController: UINavigationController ,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.theme_backgroundColor = ["#FFF"]
        
        self.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
        
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        else
        {
            return true
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithshouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        else
        {
            return true
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        else
        {
            return true
        }
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let viewController = super.popViewController(animated: animated)

        return viewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension APBaseNavigationViewController {
    
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return viewControllers.last
    }
    
    open override var childViewControllerForStatusBarHidden: UIViewController? {
        return viewControllers.last
    }
}
