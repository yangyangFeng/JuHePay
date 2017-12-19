//
//  APBillViewController.swift
//  AggregatePay
//
//  Created by cnepay on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBillViewController: APBaseViewController,APBillSelectViewDelegate {
    
    func clickSelectBtn(index: Int) {
        print(index)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账单"
        self.view.backgroundColor = UIColor(hex6: 0xf5f5f5)

        let selectView = APBillSelectView.init(titleArray: ["交易查询","结算查询","分润查询","提现查询"])
        selectView.delegate = self
        self.view.addSubview(selectView)
        selectView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0);
            make.height.equalTo(40)
        }
        
        let wayView = APBillDateWayView.init()
        self.view.addSubview(wayView)
        wayView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(80+10+60)
            make.top.equalTo(selectView.snp.bottom)
        }
        wayView.whenClickBtnBlock { (currentTitle, currentBtnType) in
            print(currentTitle,currentBtnType)
            selectView.setBtnIndex(index: currentBtnType.rawValue)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
