//
//  APMineViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import SnapKit
//SnapKit
import SwiftTheme



class APMineViewController: APBaseViewController {

    lazy var btn: UIButton = {
        let temp = UIButton(type: UIButtonType.system)
        temp.setTitle("点击", for: UIControlState.normal)
        temp.addTarget(self, action: #selector(action), for: UIControlEvents.touchUpInside)
        temp.frame = CGRect(x: 130, y: 100, width: 100, height: 100)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vhl_setNavBackgroundColor(UIColor.white)
        
        
        
//        ThemeManager.setTheme(plistName: "APTheme_Normal", path: .mainBundle)
        
        view.backgroundColor = UIColor.white
        
        title = "我的"
        
        view.addSubview(btn)
        
        UIApplication.shared.theme_setStatusBarStyle([.lightContent,.default], animated: true)
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        
   
        let titleAttributes = APGlobalPicker.barTextColors.map { (hexString) in
            return [
                NSAttributedStringKey.foregroundColor: UIColor(rgba: hexString),
            ]
        }
        
        
        self.navigationController?.navigationBar.theme_barTintColor = ["#FFF","#000"]
        self.navigationController?.navigationBar.theme_tintColor = ["#000","#FFF"]
        
        self.navigationController?.navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker.pickerWithAttributes(titleAttributes)
        
        btn.theme_backgroundColor = ["#FFF","#ABB"]
        
        
        
        // Do any additional setup after loading the view.
        
        
    }

    @objc func action()
    {
        print("点击")
        if ThemeManager.currentThemeIndex == 0 {
            ThemeManager.setTheme(index: 1)
        }
        else
        {
            ThemeManager.setTheme(index: 0)
        }
        
        self.navigationController?.pushViewController(APServiceViewController(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
