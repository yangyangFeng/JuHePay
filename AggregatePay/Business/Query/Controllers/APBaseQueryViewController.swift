//
//  APBaseQueryViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseQueryViewController: APBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(datePickerFormsCell)
        datePickerFormsCell.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(44)
        }
    }

    
    lazy var datePickerFormsCell: APDatePickerFormsCell = {
        let view = APDatePickerFormsCell()
        return view
    }()
}
