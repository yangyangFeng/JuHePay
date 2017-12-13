//
//  APServiceViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

import SwiftTheme
import Toast_Swift

class APServiceViewController: APBaseViewController {

    
    lazy var btn: UIButton = {
        let temp = UIButton(type: UIButtonType.system)
        temp.setTitle("点击", for: UIControlState.normal)
        temp.addTarget(self, action: #selector(action), for: UIControlEvents.touchUpInside)
        temp.frame = CGRect(x: 130, y: 100, width: 100, height: 100)
        return temp
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vhl_setNavBackgroundColor(UIColor.yellow)
        
        self.ap_setStatusBarStyle(.lightContent)
        
        self.view.backgroundColor = UIColor.white
        
        title = "客服"
        
        view.addSubview(btn)
        

        
    }

    @objc func action()
    {
//        if ThemeManager.currentThemeIndex == 0 {
//            ThemeManager.setTheme(index: 1)
//            view.makeToast("这是一个吐司")
//        }
//        else
//        {
//            ThemeManager.setTheme(index: 0)
//        }
//        view.makeToast("这是一个吐司")
        self.view.makeToastActivity(.center)
        
        
    }
    
    @objc func theme(notice:NSNotification)
    {
        print("改变主题")
        
        if ThemeManager.currentThemeIndex == 0 {
            self.vhl_setNavBackgroundColor(UIColor.green)
        }
        else
        {
            self.vhl_setNavBackgroundColor(UIColor.cyan)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
