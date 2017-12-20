//
//  APModifySuccessViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APModifySuccessBlock = () -> Void

class APModifySuccessViewController: APBaseViewController {
    
    var strongSelf: APModifySuccessViewController?
    var modifySuccessBlock: APModifySuccessBlock?
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.theme_image = ["sys_modify_success_icon"]
        return view
    }()
    
    lazy var confirmButton: UIButton = {
        let view = UIButton()
        view.setTitle("确定", for: .normal)
        view.layer.cornerRadius = 50/2
        view.layer.masksToBounds = true
        view.titleLabel?.textAlignment = .center
        view.theme_setBackgroundImage(["version_update_but_bg"], forState: .normal)
        view.theme_setTitleColor(["#422f02"], forState: .normal)
        view.addTarget(self, action: #selector(confirmButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    deinit {
        print( String(describing: self.classForCoder) + "已释放")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.main.bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleHeight,
                                      UIViewAutoresizing.flexibleWidth]
        self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
        //强引用,不然按钮点击不能执行
        strongSelf = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
        view.addSubview(imageView)
        view.addSubview(confirmButton)
        
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(208)
            make.height.equalTo(201)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }
        
        confirmButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(30)
            make.right.equalTo(contentView.snp.right).offset(-30)
            make.height.equalTo(44)
        }
    }
    
    func show(block: @escaping APModifySuccessBlock) {
        let window: UIWindow = UIApplication.shared.keyWindow!
        view.frame = window.bounds
        window.addSubview(view)
        window.bringSubview(toFront: view)
        modifySuccessBlock = block
    }
    
    func diss() {
        view.removeFromSuperview()
        strongSelf = nil
    }
    
    @objc func confirmButton(_ button: UIButton) {
        diss()
        modifySuccessBlock!()
    }

}
