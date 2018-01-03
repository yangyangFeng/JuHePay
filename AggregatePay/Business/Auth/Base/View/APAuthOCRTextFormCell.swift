//
//  APAuthScanTextFormCell.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APOCRTapHandle = () -> Void

class APAuthOCRTextFormCell: APAuthBaseTextFormCell {

    public var tapHandle: APOCRTapHandle!
     let scanButton = UIButton()
    
    override var enable: Bool {
        didSet {
            textField.isUserInteractionEnabled = enable
            scanButton.isUserInteractionEnabled = enable
        }
    }
    
    override init() {
        super.init()
        
       
        scanButton.setImage(UIImage.init(named: "auth_scan_button"), for: .normal)
        scanButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        addSubview(scanButton)
        scanButton.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tap() {
        tapHandle()
    }
}
