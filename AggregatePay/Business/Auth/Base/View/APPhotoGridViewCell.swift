 //
//  APPhotoGridView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import Alamofire

class APPhotoGridViewCell: UICollectionViewCell {

   fileprivate let gridHeadLabel: UILabel = UILabel()
   fileprivate let gridBottomLabel: UILabel = UILabel()
   fileprivate let gridImageView: UIImageView = UIImageView()
    
    var model: APGridViewModel = APGridViewModel() {
        didSet {
            gridHeadLabel.text = model.headMessage
            gridBottomLabel.text = model.bottomMessage
            gridImageView.image = UIImage.init(named: (model.placeHolderImageName)!)
            
            if let image = model.image {
                setImage(image: image)
                model.fileName = nil
            }
            
            if let filename = model.fileName {
                if filename.count > 0 {
                    downloadImage(withFilename: filename)
                }
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
    
    

    func downloadImage(withFilename: String) {
        
        let request = APDownloadImageRequest()
        request.fileId = withFilename
        
        APNetworking.download(
            fileName: request.fileId,
            params: request,
            success: { (image) in
            self.model.image = image
            self.setImage(image: image)

        }) { (error) in
            self.gridImageView.image = UIImage.init(named: "auth_image_load_failure")
            self.model.gridState = .failure
        }
    }
    
    func setImage(image: UIImage) {
        
        gridImageView.image = image
        model.gridState = .canPreview
        model.setImageComplete?(image)
    }
    
    // MARK: -- UI
    func layoutViews() {
        
        backgroundColor = UIColor.white
        gridImageView.contentMode = .scaleAspectFit
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
