//
//  APModifyViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APModifyViewController: APBaseViewController {
    
    let leftOffset: Float = 30
    let rightOffset: Float = -30
    let cellHeight: Float = 44
    let subimtHeight: Float = 41
    
    
    //MARK: ------------- 全局属性
    
    lazy var oldPasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请输入旧密码"
        view.button.isHidden = true
        return view
    }()
    
    lazy var oncePasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请输入新密码(6-16位字母、数字或下划线)"
        view.button.isHidden = true
        return view
    }()
    
    lazy var twicePasswordCell: APPasswordFormsCell = {
        let view = APPasswordFormsCell()
        view.inputRegx = .password
        view.textField.placeholder = "请再次输入新密码"
        return view
    }()
    
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("提交", for: .normal)
        return view
    }()
    
    //MARK: ------------- 生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        createSubviews()
        registerCallBacks()
        registerObserve()
    }
   
    //MARK: ------------- 私有方法
    
    private func  createSubviews() {
        view.addSubview(oldPasswordCell)
        view.addSubview(oncePasswordCell)
        view.addSubview(twicePasswordCell)
        view.addSubview(submitCell)
        
        oldPasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        oncePasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(oldPasswordCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        twicePasswordCell.snp.makeConstraints { (make) in
            make.top.equalTo(oncePasswordCell.snp.bottom)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(cellHeight)
        }
        
        submitCell.snp.makeConstraints { (make) in
            make.top.equalTo(twicePasswordCell.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(leftOffset)
            make.right.equalTo(view.snp.right).offset(rightOffset)
            make.height.equalTo(subimtHeight)
        }
        
    }
    private func registerCallBacks() {
        weak var weakSelf = self
        
        oldPasswordCell.textBlock = { (key, value) in
            
        }
        
        oncePasswordCell.textBlock = { (key, value) in
            
        }
        
        twicePasswordCell.textBlock = { (key, value) in
            
        }
        
        submitCell.buttonBlock = { (key, value) in weakSelf?.navigationController?.pushViewController(APModifySuccessViewController())
        }
    }
    
    private func registerObserve() {
        
    }
    

}
