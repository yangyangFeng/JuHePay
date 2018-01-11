//
//  APShareTemplateBar.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APShareTemplateBar: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    var delegate : AP_ActionProtocol?
    
    var dataSource : [TemplateItemData] = [TemplateItemData.init("PromoteTemplate1", selected: true),
                                           TemplateItemData.init("PromoteTemplate2", selected: false),
                                           TemplateItemData.init("PromoteTemplate3", selected: false)]
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 62, height: 150)
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
    
    func templateImageIndex(_ index : Int) -> UIImage?{
        let cell : APShareTemplateItemView = (collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as! APShareTemplateItemView)
        return cell.imageView.image
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell : APShareTemplateItemView = collectionView.dequeueReusableCell(withClass: APShareTemplateItemView.self, for: indexPath)!
        let itemData = dataSource[indexPath.row];
        cell.imageView.image = UIImage.init(named: itemData.imageName!)
        cell.select = itemData.isSelected!
        if indexPath.row != 0 {
            cell.leftLabel.text = "模板"+String(indexPath.row)
        }
        else
        {
            cell.leftLabel.text = "默认"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell : APShareTemplateItemView = collectionView.cellForItem(at: indexPath) as! APShareTemplateItemView
        delegate?.AP_Action_Click?(cell.imageView.image as Any)
        for item in dataSource {
            item.isSelected = false
        }
        let itemData = dataSource[indexPath.row];
        itemData.isSelected = true
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class APShareTemplateItemView: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "PromoteTemplate1")
      
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
    
    var select : Bool = true{
        didSet{
            if select {
                imageView.borderColor = UIColor.green
                imageView.borderWidth = 0.5
            }
            else
            {
                imageView.borderColor = UIColor.clear
                imageView.borderWidth = 0.5
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        imageView.image = UIImage.init(named: "推广广告模版1")
        leftLabel.text = "默认"
        righLabel.text = "免费"
        
        let qrCode = UIImageView.init(image: UIImage.init(named: "Promote_QrCode"))
        
        contentView.addSubview(imageView)
        contentView.addSubview(leftLabel)
        contentView.addSubview(righLabel)
        imageView.addSubview(qrCode)
        
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
        qrCode.snp.makeConstraints { (make) in
            make.width.height.equalTo(17)
            make.centerX.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TemplateItemData {
    var imageName : String?
    var isSelected : Bool?
    init(_ image:String,selected:Bool) {
        imageName = image
        isSelected = selected
    }
}

