//
//  APModifyViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 修改密码
 */
class APModifyViewController: APSystemBaseViewController {
    
    var newPasswordFormsCell: APNewPasswordFormsCell = APNewPasswordFormsCell()
    var repeatPasswordFormsCell: APRepeatPasswordFormsCell = APRepeatPasswordFormsCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newPasswordFormsCell)
        view.addSubview(repeatPasswordFormsCell)
        
        newPasswordFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(30)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cellHeight)
        }
        
        repeatPasswordFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(newPasswordFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cellHeight)
        }
    }

}







