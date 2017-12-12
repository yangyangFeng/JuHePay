//
//  APKeyboardButtonView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APKeyboardButtonView: UIView {
    
    //背景(UIImageView--背景图片保持图片尺寸正比例)
    //图标(UIImageView--不能有标题)
    //标题(UILabel--不能有图标)
    //触发事件(UIButton--覆盖最外层用于用户点击)

    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
