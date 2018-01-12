//
//  APSegmentQueryViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSegmentQueryViewController: APBaseViewController {
    
    var currentVC: UIViewController?

    var selectChildIndex: Int = 0 {
        willSet{
            print(self.childViewControllers.count)
            let childVC = self.childViewControllers[newValue]
            view.bringSubview(toFront: childVC.view)
            currentVC = childVC
        }
    }
    
    lazy var segmentView: APSegmentControl = {
        let segmentRect = CGRect.init(x: 0, y: 0, width: K_Width, height: 40)
        let view = APSegmentControl(["交易查询","分润查询"], frame: segmentRect)
        view.backGroundColor = "#f5f5f5"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账单"
        navigationItem.rightBarButtonItem = rightBarButtonItem
        weak var weakSelf = self
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        segmentView.segmentBlock =  { index in
            weakSelf?.selectChildIndex = index
        }
       
        self.addChildViewController(APTradingQueryViewController())
        self.addChildViewController(APProfitsQueryViewController())
        
        addChildVC(vc: self.childViewControllers[0])
        addChildVC(vc: self.childViewControllers[1])
        
        selectChildIndex = 0
    }
    
    func addChildVC(vc: UIViewController) {
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(segmentView.snp.bottom)
        }
    }
    
    //MARK: ---- action
    @objc func barButtonItemAction() {
        if selectChildIndex == 0 {
            let childVC = self.childViewControllers[0] as! APTradingQueryViewController
            childVC.queryButAction()
        }
        else {
            let childVC = self.childViewControllers[1] as! APProfitsQueryViewController
            childVC.queryButAction()
        }
    }

    lazy var rightBarButtonItem: UIBarButtonItem = {
        let view = APBarButtonItem.ap_barButtonItem(self,
                                                    title: "查询",
                                                    action: #selector(barButtonItemAction),
                                                    titleColor: "#c8a556")
        return view
    }()
    
}
