//
//  APForgetViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 忘记密码
 */
class APForgetViewController: APSystemBaseViewController {
    
    var prompt: UILabel = UILabel()
    var mobileFormsCell: APSMSTextFormsCell = APSMSTextFormsCell()
    var phoneNumberFormsCell: APPhoneNumberFormsCell = APPhoneNumberFormsCell()
    var modify: UIButton = UIButton()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prompt.text = "为了保障您的账户安全，请输入注册手机号码进行验证。"
        
        modify.titleLabel?.textAlignment = .center
        modify.setTitle(_ : "提交", for: .normal)
        modify.setTitleColor(_ : UIColor.black, for: .normal)
        modify.addTarget(self,
                         action: #selector(clickModifyVC),
                         for: .touchUpInside)
        
        view.addSubview(prompt)
        view.addSubview(mobileFormsCell)
        view.addSubview(phoneNumberFormsCell)
        view.addSubview(modify)
        
        prompt.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(30)
        }
        
        mobileFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(prompt.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cellHeight)
        }
        
        phoneNumberFormsCell.snp.makeConstraints { (make) in
            make.top.equalTo(mobileFormsCell.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cellHeight)
        }
        
        modify.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNumberFormsCell.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(cellHeight)
        }
    }

    // 点击注册按钮
    @objc func clickModifyVC() {
        let modifyVC: APModifyViewController = APModifyViewController()
        self.navigationController?.pushViewController(modifyVC, animated: true)
    }

}








