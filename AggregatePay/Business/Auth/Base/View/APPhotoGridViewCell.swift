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
   fileprivate let gridImageView: UIImageView = UIImageView()
    
    var model: APGridViewModel? {
        didSet {
            gridHeadLabel.text = model?.headMessage
            gridBottomLabel.text = model?.bottomMessage
            gridImageView.image = UIImage.init(named: (model?.placeHolderImageName)!)
            gridImageView.contentMode = .scaleAspectFit
            if let image = model?.image {
                gridImageView.image = image
                model?.gridState = .canPreview
                model?.setImageComplete?(image)
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
        contentView.addSubview(gridImageView)
        contentView.addSubview(gridBottomLabel)
        
        gridHeadLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(0)
        }
        gridImageView.snp.makeConstraints { (make) in
            make.top.equalTo(gridHeadLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(127)
            make.height.equalTo(83)
        }
        gridBottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gridImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

}
