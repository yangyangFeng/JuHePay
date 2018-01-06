//
//  APAlertController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //标题字体样式（红色，字体放大）
        let titleFont = UIFont.systemFont(ofSize: 18)
        let titleAttribute = NSMutableAttributedString.init(string: self.title!)
        titleAttribute.addAttributes([NSAttributedStringKey.font:titleFont,
                                      NSAttributedStringKey.foregroundColor:UIColor(hex6: 0x7f5e12)],
                                     range:NSMakeRange(0, (self.title?.characters.count)!))
        self.setValue(titleAttribute, forKey: "attributedTitle")
        
        //消息内容样式
        let messageFont = UIFont.systemFont(ofSize: 13)
        let messageAttribute = NSMutableAttributedString.init(string: self.message!)
        messageAttribute.addAttributes([NSAttributedStringKey.font:messageFont,
                                        NSAttributedStringKey.foregroundColor:UIColor(hex6: 0x4c370b)],
                                       range:NSMakeRange(0, (self.message?.characters.count)!))
        self.setValue(messageAttribute, forKey: "attributedMessage")
    }
    
    @objc func goBackAction()
    {
        navigationController?.popViewController()
    }

    override func addAction(_ action: UIAlertAction) {
        super.addAction(action)
        if  action.style == .default {
            action.setValue(UIColor(hex6: 0xc8a556), forKey:"titleTextColor")
        }
        else if action.style == .cancel {
            action.setValue(UIColor(hex6: 0x484848), forKey:"titleTextColor")
        }
    }

}
