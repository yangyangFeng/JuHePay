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
    
    lazy var segmentView: APSegmentControl = {
        let segmentRect = CGRect.init(x: 0, y: 0, width: K_Width, height: 40)
        let view = APSegmentControl(["交易查询","分润查询"], frame: segmentRect)
        view.backGroundColor = "#f5f5f5"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }

        weak var weakSelf = self
        segmentView.segmentBlock =  { index in
            weakSelf?.selectChildVC(atIndex: index)
        }
        
        self.addChildViewController(APTradingQueryViewController())
        self.addChildViewController(APProfitsQueryViewController())
    
        for vc in self.childViewControllers{
            view.addSubview(vc.view)
            vc.view.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(view)
                make.top.equalTo(segmentView.snp.bottom)
            }
        }
        
        selectChildVC(atIndex: 0)
    }
    
    func selectChildVC(atIndex: Int) {
        let childVC: UIViewController = self.childViewControllers[atIndex]
        view.bringSubview(toFront: childVC.view)
    }
    
}
