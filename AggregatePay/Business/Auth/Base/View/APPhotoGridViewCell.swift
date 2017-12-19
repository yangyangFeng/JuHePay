//
//  APPhotoGridView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPhotoGridViewCell: UICollectionViewCell {

   fileprivate let gridHeadLabel: UILabel = UILabel()
   fileprivate let gridBottomLabel: UILabel = UILabel()
   fileprivate let gridButton: UIButton = UIButton()
    
    var model: APGridViewModel? {
        didSet {
            gridHeadLabel.text = model?.headMessage
            gridBottomLabel.text = model?.bottomMessage
            gridButton.setBackgroundImage(UIImage.init(named: (model?.placeHolderImageName)!), for: .normal)
            if let image = model?.image {
                gridButton.setBackgroundImage(UIImage.init(), for: .normal)
                gridButton.setImage(image, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -- UI
    func layoutViews() {
        
        backgroundColor = UIColor.white
        gridHeadLabel.textColor = UIColor.init(hex6: 0x7a7a7a)
        gridHeadLabel.font = UIFont.systemFont(ofSize: 13)
        gridBottomLabel.textColor = UIColor.init(hex6: 0x7a7a7a)
        gridBottomLabel.font = UIFont.systemFont(ofSize: 13)
        
        contentView.addSubview(gridHeadLabel)
        contentView.addSubview(gridButton)
        contentView.addSubview(gridBottomLabel)
        
        gridHeadLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(0)
        }
        gridButton.snp.makeConstraints { (make) in
            make.top.equalTo(gridHeadLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(127)
            make.height.equalTo(83)
        }
        gridBottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gridButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

}
