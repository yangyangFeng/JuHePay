//
//  APTradingQuerySearchBar.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APTradingQueryHeaderView: UIView {

    init() {
        
        super.init(frame: CGRect.zero)
    
        self.layer.contents = UIImage(named: "ReturnBillHead_BG")?.cgImage
        
        let datePickerCell = APDatePickerFormsCell()
        let searchToolBar = APQuerySearchToolBar()
        
        datePickerCell.backgroundColor = UIColor.clear
        searchToolBar.backgroundColor = UIColor.clear
        
        addSubview(datePickerCell)
        addSubview(searchToolBar)
        
        datePickerCell.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.right.equalTo(0)
            make.height.equalTo(44)
        }
        
        searchToolBar.snp.makeConstraints { (make) in
            make.top.equalTo(datePickerCell.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
