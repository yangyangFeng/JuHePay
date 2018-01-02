//
//  APAuthBaseViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import KVOController

class APAuthBaseViewController: APBaseViewController {

    let authHeadMessage: UILabel = UILabel()
    let scrollView: UIScrollView = UIScrollView()
//  提交表单的父视图
    let containerView: UIView = UIView()
    var collectionView: UICollectionView?
    let formCellView = UIView()
    var layout: UICollectionViewFlowLayout?
    var gridViewModels = [APGridViewModel]()
    var currentGridModel: APGridViewModel?
    
    let authSubmitCell: APAuthSubmitCell = APAuthSubmitCell()
    let inputTipLabel = UILabel()
    let inputTipView = UIView()
    let cellHeight = 146
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutWithContainer()
        
        if let _ = processView() {
            setUpNavi()
        }
        
        ap_setStatusBarStyle(.lightContent)
        registerCallBacks()
  }
    
    func registerCallBacks() {
        
        weak var weakSelf = self
        authSubmitCell.buttonBlock = {(key, value) in
            weakSelf?.commit()
        }
    }
    
    func commit() {}
}

// MARK: LayoutView
extension APAuthBaseViewController {
    
    func setUpNavi() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: AP_navigationLeftItemImage(),
                                                                                      style: .done,
                                                                                      target: self,
                                                                                      action: #selector(backAction))
    }
    
    private func layoutWithContainer() {
        
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
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        
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
        inputTipLabel.isHidden = true
        
        let buttonView = UIButton()
        buttonView.backgroundColor = view.backgroundColor
        
        view.addSubview(scrollView)
        view.addSubview(headMessageView)
        headMessageView.addSubview(authHeadMessage)
        buttonView.addSubview(authSubmitCell)
        view.addSubview(buttonView)
        scrollView.addSubview(containerView)
        containerView.addSubview(collectionView!)
        containerView.addSubview(formCellView)
        containerView.addSubview(inputTipView)
        inputTipView.addSubview(inputTipLabel)
        
        var isProcessView = false
        if let _ = processView() {
            isProcessView = true
        }
        headMessageView.snp.makeConstraints { (make) in
            make.top.equalTo(headMessageView.superview!).offset(isProcessView ? 40 : 0)
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

extension APAuthBaseViewController {
    @objc func backAction() {
//        weak var weakSelf = self
//        APAlertManager.show(param: { (param) in
//            param.apMessage = "是否退出资质认证?"
//            param.apConfirmTitle = "继续认证"
//            param.apCanceTitle = "确定"
//        }, confirm: { (confirmAction) in
//            let navi = weakSelf?.authNavigation()
//            navi?.finishAuths?()
//
//        }, cancel: {(cancelAction) in})
        authNavigation()?.finishAuths?()
    }
}

extension APAuthBaseViewController {
    func authNavigation() -> APAuthNaviViewController? {
        var nav: APAuthNaviViewController?
        if (navigationController?.isKind(of: APAuthNaviViewController.self))! {
            nav = navigationController as? APAuthNaviViewController
        }
        return nav
    }
    
    @objc func processView() -> APBillSelectView? {
        return authNavigation()?.processView
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
        currentGridModel = gridModel
        
        switch gridModel.gridState {
        case .canPreview:
            let previewManager = APPhotoPreviewManager()
            previewManager.show(fromController: self, image: gridModel.image!)
            previewManager.photoPreview.photoPreviewHandle = {(isUse) in
                if !isUse {
                    gridModel.tapedHandle?()
                }
            }
        case .normal:
            gridModel.tapedHandle?()
        default:
            break
        }
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
