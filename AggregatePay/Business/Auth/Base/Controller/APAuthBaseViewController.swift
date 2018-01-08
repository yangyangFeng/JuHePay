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
    
    var gridViewModels = [APGridViewModel]()
    var currentGridModel: APGridViewModel?
    var auth: APAuth?
    var canEdit: Bool = false
    
    let authSubmitCell: APAuthSubmitCell = APAuthSubmitCell()
    let cellHeight = 146
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiConfing()
        
        registerCallBacks()
        
        //如果是第一次提交实名认证，不需要回显
        if !(APAuthHelper.sharedInstance.realNameAuthState == .None) {
            loadAuthInfo()
        }
        
        if let authInfo = auth {
            canEdit = (authInfo.state == .Failure) || (authInfo.state == .None)
        } else {
            canEdit = true
        }
  }
    
    func registerCallBacks() {
        
        weak var weakSelf = self
        authSubmitCell.buttonBlock = {(key, value) in
            weakSelf?.commit()
        }
    }
    
    func commit() {}
    
    func loadAuthInfo() {}
    
    func showAuthFailureBanner(failureReason: String) {
        inputTipLabel.text = failureReason
        inputTipView.backgroundColor = UIColor.init(hex6: 0xffe3e3)
        inputTipLabel.textColor = UIColor.init(hex6: 0xe4544c)
    }
    
    lazy private var headMessageView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(hex6: 0xfff4d9)
        return view
    }()
    
    lazy var headMessageLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.init(hex6: 0xd09326)
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = UIColor.init(hex6: 0xfff4d9)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.clipsToBounds = false
        scrollView.backgroundColor = UIColor.init(hex6: 0xf5f5f5)
        containerView.backgroundColor = scrollView.backgroundColor
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    
    lazy var containerView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor.init(hex6: 0xf5f5f5)
        return view
    }()
    
    lazy private var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(APPhotoGridViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(APPhotoGridViewCell.self))
        return collectionView
    }()
    
    lazy var formCellView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(hex6: 0xe8e8e8)
        return view
    }()
    
    lazy var inputTipView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(hex6: 0xfff4d9)
        view.isHidden = true
        return view
    }()
    
    lazy var inputTipLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.init(hex6: 0xd09326)
        label.text = "请注意核对您的姓名与身份证号码，若不正确请重新识别或手动输入。"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy private var commitButtonSuperView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(hex6: 0xf5f5f5)
        return view
    }()
}

// MARK: LayoutView
extension APAuthBaseViewController {
    
    func uiConfing() {
        
        if let _ = processView() {
            setUpNavi()
        }
        
        ap_setStatusBarStyle(.lightContent)
        
        layoutHeaderView()
        layoutCommitButton()
        layoutScrollView()
        layoutCollectionView()
        layoutFormCellViews()
    }
    
    func setUpNavi() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: AP_navigationLeftItemImage(),
                                                                                      style: .done,
                                                                                      target: self,
                                                                                      action: #selector(backAction))
    }
    
    private func layoutHeaderView() {
        
        view.addSubview(headMessageView)
        headMessageView.addSubview(headMessageLabel)
        
        var isProcessView = false
        if let _ = processView() {
            isProcessView = true
        }
        headMessageView.snp.makeConstraints { (make) in
            make.top.equalTo(headMessageView.superview!).offset(isProcessView ? 40 : 0)
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        headMessageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        // TODO: ScrollView
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(headMessageLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(commitButtonSuperView.snp.top)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func layoutCollectionView() {
        
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints({ (make) in
            make.right.left.equalToSuperview()
        })
    }
    
    private func layoutFormCellViews() {
        containerView.addSubview(formCellView)
        containerView.addSubview(inputTipView)
        inputTipView.addSubview(inputTipLabel)
        
        formCellView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo((collectionView.snp.bottom)).offset(9)
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
    
    private func layoutCommitButton() {
        
        authSubmitCell.isEnabled = false
        commitButtonSuperView.addSubview(authSubmitCell)
        view.addSubview(commitButtonSuperView)
        
        commitButtonSuperView.snp.makeConstraints { (make) in
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
    }
}

extension APAuthBaseViewController {
    @objc func backAction() {

       let alert = APAlertManager.alertController(param: { (param) in
            param.apMessage = "是否退出身份认证?"
            param.apConfirmTitle = "继续认证"
            param.apCanceTitle = "确定"
        }, confirm: {(confirmAction) in
        

        }, cancel: { [weak self] (cancelAction) in
            let navi = self?.authNavigation()
            navi?.finishAuths?()
       })
        present(alert, animated: true, completion: nil)
//        authNavigation()?.finishAuths?()
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
        
        if gridModel.editState {
            switch gridModel.gridState {
            case .canPreview:
                toPreview(gridModel: gridModel)
            case .normal:
                gridModel.tapedHandle?()
            default:
                break
            }
        } else {
            if .canPreview == gridModel.gridState {
                toPreview(gridModel: gridModel)
            }
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
    
    func toPreview(gridModel: APGridViewModel) {
        let previewManager = APPhotoPreviewManager()
        previewManager.isOnlyPreView = !gridModel.editState
        previewManager.show(fromController: self, image: gridModel.image!)
        previewManager.photoPreview.photoPreviewHandle = {(isUse) in
            if !isUse {
                gridModel.tapedHandle?()
            }
        }
    }
}
