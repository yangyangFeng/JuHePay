//
//  APAuthScanTextFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthOCRTextFormCell: APAuthBaseTextFormCell {

    override init() {
        super.init()
        
        let scanButton = UIButton()
        scanButton.setImage(UIImage.init(named: "auth_scan_button"), for: .normal)
        addSubview(scanButton)
        scanButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
