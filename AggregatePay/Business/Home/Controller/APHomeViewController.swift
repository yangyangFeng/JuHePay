//
//  APHomeViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeViewController: APBaseViewController, APHomeMenuViewDelegate, APKeyboardCompositionViewDelegate {
    
    lazy var homeMenuView: APHomeMenuView = {
        let view = APHomeMenuView(delegate: self)
        return view
    }()
    
    lazy var keyboardCompositionView: APCollectionCompositionView = {
        let view = APCollectionCompositionView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收款"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
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
    
    //MARK: ------- APKeyboardCompositionViewDelegate
    
    func didKeyboardConfirm(param: Any) {
        let params = param as! NSDictionary
        let totalAmount: String = params.object(forKey: "totalAmount") as! String
        let menuModel: APHomeMenuModel = params.object(forKey: "menuModel") as! APHomeMenuModel
        print(totalAmount)
        print(menuModel)
        if menuModel.payWay == "0" {
            let placeVC = APCollectionPlaceViewController()
            self.navigationController?.pushViewController(placeVC,
                                                          animated: true)
        }
        else {
            let qrCodePayElementVC = APQRCodePayElementViewController()
            self.navigationController?.pushViewController(qrCodePayElementVC,
                                                          animated: true)
        }
    }
    
    //MARK: ------- APHomeMenuViewDelegate
    
    func selectHomeMenuItemSuccess(itemModel: APHomeMenuModel) {
        keyboardCompositionView.menuModel = itemModel
    }
    
    func selectHomeMenuItemFaile(message: String) {
        weak var weakSelf = self
        let loginVC = APBaseNavigationViewController(rootViewController: APLoginViewController())
        self.present(loginVC, animated: true) {
            weakSelf?.keyboardCompositionView.isLogin = true
        }
    }
  

}
