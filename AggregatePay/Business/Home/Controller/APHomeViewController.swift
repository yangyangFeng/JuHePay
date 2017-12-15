//
//  APHomeViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/6.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APHomeViewController: APBaseViewController, APHomeMenuViewDelegate {

    lazy var homeMenuView: APHomeMenuView = {
        let view = APHomeMenuView(delegate: self)
        return view
    }()
    
    lazy var keyboardCompositionView: APKeyboardCompositionView = {
        let view = APKeyboardCompositionView()
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
    
    //MARK: ------- APHomeMenuViewDelegate
    
    func selectHomeMenuItemSuccess(itemModel: APHomeMenuModel) {
        keyboardCompositionView.setDisplayWayTypeImage(string: itemModel.wayIconImage)
    }
    
    func selectHomeMenuItemFaile(message: String) {
        APAlert.show(message: message,
                     confirmTitle: "确定",
                     canceTitle: "取消",
                     confirm: { (action) in
                        let loginVC = APBaseNavigationViewController(rootViewController: APLoginViewController())
                        self.present(loginVC, animated: true, completion: nil)
        }) { (action) in
            
        }
    }
  

}
