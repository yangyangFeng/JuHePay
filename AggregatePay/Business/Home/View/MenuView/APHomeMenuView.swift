//
//  APHomeMenuView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

protocol APHomeMenuViewDelegate: NSObjectProtocol {
    func selectHomeMenuItemSuccess(itemModel: APHomeMenuModel)
    func selectHomeMenuItemFaile(message: String)
}

class APHomeMenuView: UIView {
    
    private var listDataSource : NSArray = {
        let path = Bundle.main.path(forResource: "Home_Menu_Config", ofType: "plist")
        var arr : NSArray = NSArray(contentsOfFile: path!)!
        return arr
    }()
    
    private var selectIndex: Int = 0 {
        willSet {
            let item: APHomeMenuButtonView = buttonArray[newValue]
            item.showHighlighted()
        }
        didSet {
            if selectIndex != oldValue  {
                let item: APHomeMenuButtonView = buttonArray[oldValue]
                item.dissHighlighted()
            }
        }
    }
    
    private var buttonArray = [APHomeMenuButtonView]()
    
    private let contentView: UIView = UIView()
    
    var delegate: APHomeMenuViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init() {
        super.init(frame: CGRect.zero)
        self.layer.contents = UIImage(named: "home_menu_bg")?.cgImage
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
        for i in 0..<2 {
            for j in 0..<4 {
                let index = i * 4 + j
                let item = getHomeMenuButtonView(index: index)
                contentView.addSubview(item)
                buttonArray.append(item)
                item.addTarget(self, action: #selector(didItem(_:)))
                item.snp.makeConstraints({ (make) in
                    make.width.equalTo(contentView.snp.width).multipliedBy(0.25)
                    make.height.equalTo(contentView.snp.height).multipliedBy(0.5)
                    if i == 0 {
                        make.top.equalTo(0)
                    }
                    else{
                        make.top.equalTo(buttonArray[index-4].snp.bottom)
                    }
                    switch (j) {
                    case 0:
                        make.left.equalTo(contentView.snp.left)
                    case 1:
                        make.right.equalTo(contentView.snp.centerX)
                    case 2:
                        make.left.equalTo(contentView.snp.centerX)
                    case 3:
                        make.right.equalTo(contentView.snp.right)
                    default:
                        break
                    }
                })
            }
        }
        defaultSelectIndex(index: 0)
    }
    
    private func getHomeMenuButtonView(index: Int) -> APHomeMenuButtonView {
        
        let dataSource : NSDictionary = listDataSource[index] as! NSDictionary
        
        let itemModel = APHomeMenuModel()
        itemModel.title = dataSource.object(forKey: "title") as! String
        itemModel.norImage = dataSource.object(forKey: "norImage") as! String
        itemModel.selImage = dataSource.object(forKey: "selImage") as! String
        itemModel.wayIconImage = dataSource.object(forKey: "wayIconImage") as! String
        
        let item = APHomeMenuButtonView(itemModel: itemModel)
        item.addTarget(self, action: #selector(didItem(_:)))
        item.button.tag = index
        
        return item
    }
    
    @objc func didItem(_ button: UIButton) {
        defaultSelectIndex(index: button.tag)
    }
    
    public func defaultSelectIndex(index: Int) {
        let item: APHomeMenuButtonView = buttonArray[index]
        if item.model?.wayIconImage == "" {
            let message: String = "暂不支持"+(item.model?.title)!+"支付方式"
            delegate?.selectHomeMenuItemFaile(message: message)
            return
        }
        selectIndex = index
        delegate?.selectHomeMenuItemSuccess(itemModel: item.model!)
    }
    
}
