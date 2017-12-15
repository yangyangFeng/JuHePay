//
//  APAuthBaseViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAuthBaseViewController: APBaseViewController {

    let authProcess: UIView = UIView()
    let authHeadMessage: UILabel = UILabel()
    let scrollView: UIScrollView = UIScrollView()
    let containerView: UIView = UIView()
    var layout: UICollectionViewLayout = UICollectionViewLayout.init()
    var gridViews: UICollectionView = UICollectionView.init(frame: CGRect.init())
    
    
    var authSubmitCell: APAuthSubmitCell = APAuthSubmitCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutWithContainer()
  }
}

// MARK: LayoutView
extension APAuthBaseViewController {
    
    func layoutWithContainer() {
        
        authSubmitCell.identify = "loginSubmitID"
        
        authHeadMessage.textColor = UIColor.init(hex6: 0xD9A653)
        authHeadMessage.font = UIFont.systemFont(ofSize: 12)
        authHeadMessage.backgroundColor = UIColor.init(hex6: 0xd09326)
        
        layoutScrollView()
        layoutCollectionView()

        view.addSubview(authProcess)
        view.addSubview(authHeadMessage)
        view.addSubview(scrollView)
        view.addSubview(authSubmitCell)
        scrollView.addSubview(containerView)
        containerView.addSubview(gridViews)
        
        authProcess.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        authHeadMessage.snp.makeConstraints { (make) in
            make.top.equalTo(authProcess.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        // TODO: ScrollView
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(authHeadMessage.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        gridViews.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // FIXME: 2017年12月14日15:03:42
        authSubmitCell.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(34)
            make.right.equalToSuperview().offset(-34)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-38)
        }
    }
    
    func layoutScrollView() {
        
        scrollView.bounces = false
        scrollView.clipsToBounds = false
        containerView.backgroundColor = scrollView.backgroundColor
        
    }
    
    func layoutCollectionView() {
        gridViews.delegate = self
        gridViews.dataSource = self
        gridViews.collectionViewLayout = layout
    }
}

// MARK: UICollectionViewDelegate
extension APAuthBaseViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
}
