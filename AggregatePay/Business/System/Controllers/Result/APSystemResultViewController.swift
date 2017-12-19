//
//  APSystemResultViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSystemResultViewController: APSystemBaseViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
    }

}
