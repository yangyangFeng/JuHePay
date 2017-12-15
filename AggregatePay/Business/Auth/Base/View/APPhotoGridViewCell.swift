//
//  APPhotoGridView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPhotoGridViewCell: UICollectionViewCell {

    let gridHeadLabel: UILabel = UILabel()
    let gridBottomLabel: UILabel = UILabel()
    let gridButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: -- UI
    func layoutViews() {
        
        gridHeadLabel.textColor = UIColor.init(hex6: 0x7a7a7a)
        gridHeadLabel.font = UIFont.systemFont(ofSize: 13)
        gridBottomLabel.textColor = UIColor.init(hex6: 0x7a7a7a)
        gridBottomLabel.font = UIFont.systemFont(ofSize: 13)
        
        addSubview(gridHeadLabel)
        addSubview(gridButton)
        addSubview(gridBottomLabel)
        
        gridHeadLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
        }
        gridButton.snp.makeConstraints { (make) in
            make.top.equalTo(gridHeadLabel.snp.bottom).offset(10)
            make.right.left.equalToSuperview()
            make.height.equalTo(80)
        }
        gridBottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gridButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

}
