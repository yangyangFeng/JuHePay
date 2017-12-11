//
//  CPCodeFormsCell.swift
//  framework
//
//  Created by BlackAnt on 2017/12/6.
//  Copyright © 2017年 cne. All rights reserved.
//
/**
 *  样式：
 *  [图标|输入框|发送验证码]
 */
import UIKit

class APSMSCodeFormsCell: APBaseIconFormsCell {

    var text: UITextField = UITextField()
    var edit: UIButton = UIButton()
    
    override init() {
        super.init()
        
        edit.backgroundColor = UIColor.orange
        
        addSubview(text)
        addSubview(edit)
        
        edit.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(100)
        }
        text.snp.makeConstraints { (maker) in
            maker.left.equalTo(icon.snp.right)
            maker.right.equalTo(edit.snp.left)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
