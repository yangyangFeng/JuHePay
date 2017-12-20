//
//  APShareTemplateBar.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APShareTemplateBar: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 62, height: 118)
        layout.sectionInset = UIEdgeInsetsMake(18, 30, 0, 30)
        layout.minimumLineSpacing = 24
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        view.alwaysBounceHorizontal = true
        view.alwaysBounceVertical = false
        
        view.dataSource = self
        view.delegate = self
        
        view.register(cellWithClass: APShareTemplateItemView.self)
        return view
    }()
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : APShareTemplateItemView = collectionView.dequeueReusableCell(withClass: APShareTemplateItemView.self, for: indexPath) as! APShareTemplateItemView
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class APShareTemplateItemView: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.borderColor = UIColor.green
        view.borderWidth = 0.5
        return view
    }()
    
    let leftLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#9c9b99"]
        return view
    }()
    
    let righLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#d09326"]
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = UIImage.init(named: "推广广告模版1")
        leftLabel.text = "模板"
        righLabel.text = "免费"
        
        addSubview(imageView)
        addSubview(leftLabel)
        addSubview(righLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(-32)
        }
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(-12)
        }
        righLabel.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(-12)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
