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
    
    var modifyPasswordCell: APModifyPasswordCell = APModifyPasswordCell()
    var modifySubmitCell: APModifySubmitCell = APModifySubmitCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        
        modifyPasswordCell.identify = "modifyPasswordID"
        modifySubmitCell.identify = "modifySubmitID"
        
        view.addSubview(modifyPasswordCell)
        view.addSubview(modifySubmitCell)
        
        modifyPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        modifySubmitCell.snp.makeConstraints { (make) in
            make.top.equalTo(modifyPasswordCell.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(35)
        }
        
        modifyPasswordCell.textBlock = { (key, value) in
            print("modifyPasswordCell:\(key) ___ value:\(value)")
        }
        
        modifySubmitCell.buttonBlock = { (key, value) in
            print("modifySubmitCell:\(key) ___ value:\(value)")
        }
    }

}







