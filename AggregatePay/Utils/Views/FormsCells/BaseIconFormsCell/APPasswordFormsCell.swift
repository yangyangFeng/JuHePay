//
//  APPasswordFormsCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPasswordFormsCell: APBaseIconFormsCell {

    var text: UITextField = UITextField()
    //点击可切换显示/隐藏密码，默认隐藏。
    var edit: UIButton = UIButton()
    //输入密码后显示，点击可全部清理密码
    var delete: UIButton = UIButton()
    
    override init() {
        super.init()
        
        edit.backgroundColor = UIColor.yellow
        delete.backgroundColor = UIColor.orange
        
        addSubview(edit)
        addSubview(delete)
        addSubview(text)

        edit.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(40)
        }
        delete.snp.makeConstraints { (maker) in
            maker.right.equalTo(edit.snp.left)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
            maker.width.equalTo(40)
        }
        text.snp.makeConstraints { (maker) in
            maker.left.equalTo(icon.snp.right)
            maker.right.equalTo(delete.snp.left)
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
