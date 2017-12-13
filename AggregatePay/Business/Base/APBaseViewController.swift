//
//  APBaseViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import SwiftTheme

class APBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    
        ap_setStatusBarStyle(UIStatusBarStyle.default)
        
        initNavigationBar()
        
        initNavigationItem()
    }

    func initNavigationItem()
    {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        
        guard self.navigationController?.viewControllers.count == 1 else {
            let leftButton = UIBarButtonItem(image: AP_navigationLeftItemImage(), style: UIBarButtonItemStyle.done, target: self, action: #selector(goBackAction))
            navigationItem.leftBarButtonItem = leftButton
            return
        }
        navigationItem.leftBarButtonItem = nil
        
        //        let titleAttributes = APGlobalPicker.barTextColors.map { (hexString) in
        //            return [
        //                NSAttributedStringKey.foregroundColor: UIColor(rgba: hexString),
        //                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18),
        //                ]
        //        }
        //
        //        self.navigationController?.navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithAttributes(titleAttributes)
    }
    
    func initNavigationBar()
    {
        self.vhl_setNavBarShadowImageHidden(true)
        
        self.vhl_setNavBarTintColor(UIColor(hex6: 0xc8a556))
        
        self.vhl_setNavBackgroundColor(UIColor.init(hex6: 0x373737))
        
        self.vhl_setNavBarTitleColor(UIColor(hex6: 0xc8a556))
    }
    
    func AP_navigationLeftItemImage() -> UIImage {
        let image = UIImage.init(named: "Navigation_Back")

        return image!.withRenderingMode(.alwaysTemplate)
    }
    
    @objc func goBackAction()
    {
        navigationController?.popViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 设置当前控制器状态栏style
    ///
    /// - Parameter style:
    func ap_setStatusBarStyle(_ style : UIStatusBarStyle)
    {
        self.vhl_setStatusBarStyle(style)
    }
    
    /// 设置当前导航栏 title 颜色
    ///
    /// - Parameter color:
    func ap_setTitleColor(_ color : UIColor) {
        self.vhl_setNavBarTitleColor(color)
//        let titleAttributes = APGlobalPicker.barTextColors.map { (hexString) in
//            return [
//                NSAttributedStringKey.foregroundColor: UIColor(rgba: hexString),
//                ]
//        }
//        self.navigationController?.navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithAttributes(titleAttributes)
    }
    
    /// 设置当前控制器导航栏背景色
    ///
    /// - Parameter color:
    func ap_setNavigationBarBackGroundColor(_ color : UIColor) {
        self.vhl_setNavBackgroundColor(color)
    }

    /// 设置当前控制器导航栏是否隐藏
    ///
    /// - Parameter hidden:
    func ap_setNavigationBarHidden(_ hidden : Bool){
        self.vhl_setNavBarHidden(hidden)
    }
    
    
}
