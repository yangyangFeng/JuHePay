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
//  提交表单的父视图
    let containerView: UIView = UIView()
    var collectionView: UICollectionView?
    let formCellView = UIView()
    var layout: UICollectionViewFlowLayout?
    var gridViewModels = [APGridViewModel]()
    let authSubmitCell: APAuthSubmitCell = APAuthSubmitCell()
    let inputTipLabel = UILabel()
    let inputTipView = UIView()
    let cellHeight = 146
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutWithContainer()
  }
}

// MARK: LayoutView
extension APAuthBaseViewController {
    
   private func layoutWithContainer() {

    authSubmitCell.identify = "loginSubmitID"

    authProcess.backgroundColor = UIColor.init(hex6: 0xf5f5f5)

    let headMessageView = UIView()
    headMessageView.backgroundColor = UIColor.init(hex6: 0xfff4d9)
    authHeadMessage.textColor = UIColor.init(hex6: 0xd09326)
    authHeadMessage.font = UIFont.systemFont(ofSize: 10)
    authHeadMessage.backgroundColor = UIColor.init(hex6: 0xfff4d9)
    authHeadMessage.textAlignment = .center
//    authHeadMessage.adjustsFontSizeToFitWidth = true
    authHeadMessage.numberOfLines = 0
    authHeadMessage.lineBreakMode = NSLineBreakMode.byWordWrapping

    //    MARK: -- 设置scrollView
    scrollView.bounces = false
    scrollView.clipsToBounds = false
    scrollView.backgroundColor = UIColor.init(hex6: 0xf5f5f5)
    containerView.backgroundColor = scrollView.backgroundColor

    //    MARK: -- 设置collectionView
    layout = UICollectionViewFlowLayout.init()
    layout?.minimumLineSpacing = 0
    layout?.minimumInteritemSpacing = 0
    collectionView = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout!)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(APPhotoGridViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(APPhotoGridViewCell.self))

    //    MARK: -- 设置表单父视图
    formCellView.backgroundColor = UIColor.init(hex6: 0xe8e8e8)

    inputTipView.backgroundColor = UIColor.init(hex6: 0xfff4d9)

    inputTipLabel.backgroundColor = UIColor.init(hex6: 0xfff4d9)
    inputTipLabel.font = UIFont.systemFont(ofSize: 10)
    inputTipLabel.textColor = UIColor.init(hex6: 0xd09326)
    inputTipLabel.text = "请注意核对您的姓名与身份证号码，若不正确请重新识别或手动输入。"
    inputTipLabel.textAlignment = .center
    inputTipLabel.adjustsFontSizeToFitWidth = true

    let buttonView = UIButton()
    buttonView.backgroundColor = view.backgroundColor

    view.addSubview(scrollView)
    view.addSubview(authProcess)
    view.addSubview(headMessageView)
    headMessageView.addSubview(authHeadMessage)
    buttonView.addSubview(authSubmitCell)
    view.addSubview(buttonView)
    scrollView.addSubview(containerView)
    containerView.addSubview(collectionView!)
    containerView.addSubview(formCellView)
    containerView.addSubview(inputTipView)
    inputTipView.addSubview(inputTipLabel)

    authProcess.snp.makeConstraints { (make) in
        make.left.right.top.equalToSuperview()
        make.height.equalTo(40)
    }
    headMessageView.snp.makeConstraints { (make) in
        make.top.equalTo(authProcess.snp.bottom)
        make.left.right.equalToSuperview()
        make.height.equalTo(20)
    }
    authHeadMessage.snp.makeConstraints { (make) in
        make.left.equalToSuperview().offset(20)
        make.top.bottom.equalToSuperview()
    }

    buttonView.snp.makeConstraints { (make) in
        make.right.left.bottom.equalToSuperview()
        make.height.equalTo(100)
    }
    // FIXME: 2017年12月14日15:03:42
    authSubmitCell.snp.makeConstraints { (make) in
        make.left.equalToSuperview().offset(34)
        make.right.equalToSuperview().offset(-34)
        make.height.equalTo(40)
        make.bottom.equalToSuperview().offset(-38)
    }

    // TODO: ScrollView
    scrollView.snp.makeConstraints { (make) in
        make.top.equalTo(authHeadMessage.snp.bottom)
        make.left.right.equalToSuperview()
        make.bottom.equalTo(authSubmitCell.snp.top).offset(-40)
    }

    containerView.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
        make.width.equalToSuperview()
    }

    collectionView?.snp.makeConstraints({ (make) in
        make.right.left.equalToSuperview()
    })

    formCellView.snp.makeConstraints { (make) in
        make.left.right.equalToSuperview()
        make.top.equalTo((collectionView?.snp.bottom)!).offset(9)
        make.height.equalTo(0)
    }

    inputTipView.snp.makeConstraints { (make) in
        make.top.equalTo(formCellView.snp.bottom)
        make.left.right.equalToSuperview()
        make.height.equalTo(0)
    }
    inputTipLabel.snp.makeConstraints { (make) in
        make.top.equalTo(formCellView.snp.bottom)
        make.left.equalToSuperview().offset(20)
        make.bottom.right.equalToSuperview()
    }
}
}

extension APAuthBaseViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: --UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(APPhotoGridViewCell.self), for: indexPath) as! APPhotoGridViewCell
        cell.model = gridViewModels[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gridModel = gridViewModels[indexPath.row]
        gridModel.tapedHandle?()
    }
    
    //MARK: --UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if gridViewModels.count == 1 {
            return collectionView.bounds.size
        }
        func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
            return false
        }
        let width: CGFloat = UIScreen.main.bounds.width / 2.0
        let height: CGFloat = CGFloat(cellHeight)
        return CGSize.init(width: width, height: height)
    }
    

}
