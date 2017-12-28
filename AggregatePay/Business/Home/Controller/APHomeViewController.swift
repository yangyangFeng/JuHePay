//
//  APHomeViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeViewController: APBaseViewController,
APHomeMenuViewDelegate,
APKeyboardCompositionViewDelegate {
   
    //MARK: ---- 声明周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APUserStatusTool.userIdentityStatusTool { (identityStatus) in
            if identityStatus == .touristsUser {
                keyboardCompositionView.isLogin = false
            }
            else {
                keyboardCompositionView.isLogin = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收款"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        vhl_setNavBarBackgroundImage(UIImage.init(named: "home_nav_bg"))

        view.addSubview(homeMenuView)
        view.addSubview(keyboardCompositionView)
        
        homeMenuView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }
        keyboardCompositionView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(homeMenuView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //MARK: ---- 按钮触发
    @objc func pushBillVC() {
        let billVC = APSegmentQueryViewController()
        navigationController?.pushViewController(billVC, animated: true)
    }
    
    
    //MARK: ---- jump
    //jump collection view controller
    private func pushCollectionVC(totalAmount: String, model: APHomeMenuModel) {
        if totalAmount == "" {
            view.makeToast("请输入金额")
            return
        }
        
        if model.payWay == "0" {
            let placeVC = APCollectionPlaceViewController()
            self.navigationController?.pushViewController(placeVC,  animated: true)
        }
        else {
            let qrCodePayElementVC = APQRCodePayElementViewController()
            qrCodePayElementVC.amountStr = totalAmount
            qrCodePayElementVC.payType = model.payType
            self.navigationController?.pushViewController(qrCodePayElementVC, animated: true)
        }
    }
    
    //go to auth view controller
    private func pushAuthVC() {
        weak var weakSelf = self
        APAlertManager.show(param: { (param) in
            param.apMessage = "您还未进行身份证认证，请先进行认证。"
            param.apConfirmTitle = "去认证"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            
            let random = arc4random() % UInt32(10) + UInt32(0)
            if random % 2 == 0 {
                
                let authVC = APAuthHomeViewController()
                weakSelf?.navigationController?.pushViewController(authVC, animated: true)
            } else {
                let authNavi = APAuthNaviViewController(rootViewController: APRealNameAuthViewController())
                authNavi.finishAuths = {
                    weakSelf?.navigationController?.dismiss(animated: true, completion: nil)
                }
                weakSelf?.navigationController?.present(authNavi, animated: true, completion: nil)
                
            }
        }) { (cancelAction) in
            
        }
    }
    
    //Go To Login View Controller
    private func presentLoginVC() {
        let loginVC = APBaseNavigationViewController(rootViewController: APLoginViewController())
        self.present(loginVC, animated: true)

    }
    
    //MARK: ---- delegate
    //MARK: APKeyboardCompositionViewDelegate
    func didKeyboardConfirm(totalAmount: String, model: Any) {
        APUserStatusTool.userIdentityStatusTool { (identityStatus) in
            if identityStatus == .touristsUser {
                presentLoginVC()
            }
            else if identityStatus == .weakUser {
                pushAuthVC()
            }
            else if identityStatus == .strongUser {
                let menuModel: APHomeMenuModel = model as! APHomeMenuModel
                pushCollectionVC(totalAmount: totalAmount, model: menuModel)
            }
        }
    }
    
    //MARK: APHomeMenuViewDelegate
    func selectHomeMenuItemSuccess(itemModel: APHomeMenuModel) {
        keyboardCompositionView.menuModel = itemModel
    }
    
    func selectHomeMenuItemFaile(message: String) {
        view.makeToast(message)
        presentLoginVC()
    }
    
    //MARK: ---- lazy  loading
    lazy var homeMenuView: APHomeMenuView = {
        let view = APHomeMenuView(delegate: self)
        return view
    }()
    
    lazy var keyboardCompositionView: APCollectionCompositionView = {
        let view = APCollectionCompositionView()
        view.delegate = self
        return view
    }()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let view = APBarButtonItem.ap_barButtonItem(self , title: "账单", action: #selector(pushBillVC))
        return view
    }()

}

