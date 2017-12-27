//
//  APBaseCameraView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseCameraView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print( String(describing: self.classForCoder) + "已释放")
    }
    

}


