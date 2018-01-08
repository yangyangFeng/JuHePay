//
//  APHomeViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeViewController: APBaseViewController {
   
    //MARK: ---- 声明周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardCompositionView.isLogin = APUserInfoTool.isLogin()
        keyboardCompositionView.ap_remove()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收款"
        navigationItem.leftBarButtonItem = leftBarButtonItem
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        vhl_setNavBarBackgroundImage(UIImage.init(named: "home_nav_bg"))
        initCreateSubViews()
    }
    
    //MARK: ---- 按钮触发
    @objc func pushBillVC() {
        weak var weakSelf = self
        ap_userIdentityStatus {
            let billVC = APSegmentQueryViewController()
            weakSelf?.navigationController?.pushViewController(billVC, animated: true)
        }
    }

    //跳转收款页面
    private func pushCollectionVC(totalAmount: String, model: APHomeMenuModel) {
        if totalAmount == "" ||
            Float(totalAmount)! <= 0.0 {
            view.makeToast("请输入金额")
            return
        }
        
        if model.payWay == "0" {

            guard let realName = APUserInfoTool.info.realName else {
                self.view.AP_loadingBegin()
                APMineHttpTool.loginGetUserInfo(success: { (baseResp) in
                    self.view.AP_loadingEnd()
                    let newRealName = APUserInfoTool.info.realName
                    self.pushUnionPayVC(totalAmount: totalAmount,
                                   realName: newRealName!)
                }, faile: { (baseError) in
                    self.view.AP_loadingEnd()
                    self.view.makeToast(baseError.message)
                })
                return
            }
            pushUnionPayVC(totalAmount: totalAmount,
                           realName: realName)

        }
        else {
            let qrcpElementVC = APQRCPElementViewController()
            qrcpElementVC.amountStr = totalAmount
            qrcpElementVC.payType = model.payType
            navigationController?.pushViewController(qrcpElementVC, animated: true)
        }
    }
    
    func pushUnionPayVC(totalAmount: String, realName: String){
        let placeVC = APCollectionPlaceViewController()
        placeVC.totalAmount = totalAmount
        placeVC.realName = realName
        self.navigationController?.pushViewController(placeVC,  animated: true)
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

//MARK: ---- APHomeViewController -Extension(初始化方法)

extension APHomeViewController {
    
    func initCreateSubViews() {
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
    
}

//MARK: ---- APHomeViewController -Extension(代理方法)

extension APHomeViewController:
    APHomeMenuViewDelegate,
    APKeyboardCompositionViewDelegate  {

    //MARK: APKeyboardCompositionViewDelegate
    func didKeyboardConfirm(totalAmount: String, model: Any) {
        weak var weakSelf = self
        ap_userIdentityStatus {
            let menuModel: APHomeMenuModel = model as! APHomeMenuModel
            weakSelf?.pushCollectionVC(totalAmount: totalAmount, model: menuModel)
        }
    }
    
    //MARK: APHomeMenuViewDelegate
    func selectHomeMenuItemSuccess(itemModel: APHomeMenuModel) {
        keyboardCompositionView.menuModel = itemModel
    }
    
    func selectHomeMenuItemFaile(message: String) {
//        view.makeToast(message)
    }
}

