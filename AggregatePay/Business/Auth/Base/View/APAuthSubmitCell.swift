//
//  APAuthSubmitCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthSubmitCell: APSubmitFormsCell {

    override init() {
        super.init()
        
        button.setTitle("上传资料", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
