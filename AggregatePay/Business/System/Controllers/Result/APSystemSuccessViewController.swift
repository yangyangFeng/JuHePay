//
//  APSystemResultViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APSystemSuccessBlock = () -> Void


class APSystemSuccessViewController: APBaseViewController {

    lazy var resultImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("立即登录", for: .normal)
        return view
    }()
    
    var systemBlock: APSystemSuccessBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vhl_setNavBarBackgroundAlpha(0.0)
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        edgesForExtendedLayout =  UIRectEdge.top
        view.backgroundColor = UIColor.white
        view.addSubview(resultImageView)
        view.addSubview(submitCell)
        
        resultImageView.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view.snp.centerX)
            maker.top.equalTo(20)
            maker.width.equalTo(view.snp.width).multipliedBy(0.75)
            maker.height.equalTo(view.snp.width).multipliedBy(0.75)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(41)
        }
        
        weak var weakSelf = self
        submitCell.buttonBlock = {(key, value) in
            weakSelf?.systemBlock!()
        }
    }
    
    func show(image: String ,block: @escaping APSystemSuccessBlock) {
        resultImageView.theme_image = [image]
        systemBlock = block
    }

}
