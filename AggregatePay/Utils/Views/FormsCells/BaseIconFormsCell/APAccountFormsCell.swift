//
//  CPLoginFormsView.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//


/**
 *  样式：
 *  [图标|输入框]
 */
import UIKit

class APAccountFormsCell: APBaseIconFormsCell {

    var text: UITextField = UITextField()

    override init() {
        super.init()
        
        addSubview(text)
        
        text.snp.makeConstraints { (maker) in
            maker.left.equalTo(icon.snp.right)
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
