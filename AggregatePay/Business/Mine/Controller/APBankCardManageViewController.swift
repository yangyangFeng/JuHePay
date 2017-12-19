//
//  APBankCardManageViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBankCardManageViewController: APBaseViewController {

    lazy var bankCardView: APBankCardManageListView = {
        let view = APBankCardManageListView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.vhl_setNavBackgroundColor(UIColor.init(hex6: 0x373737))
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(bankCardView)
        bankCardView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
