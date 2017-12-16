//
//  APVersionUpgradeController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

//MARK:  APVersionUpgradeController

class APVersionUpgradeController: UIViewController {
    
    lazy var versionUpgradeView: APVersionUpgradeView = {
        let view = APVersionUpgradeView()
        return view
    }()
    
    lazy var updateButton: UIButton = {
        let view = UIButton()
        view.setTitle("立即更新", for: .normal)
        view.layer.cornerRadius = 50/2
        view.layer.masksToBounds = true
        view.titleLabel?.textAlignment = .center
        view.theme_setBackgroundImage(["version_update_but_bg"], forState: .normal)
        view.theme_setTitleColor(["#422f02"], forState: .normal)
        view.addTarget(self, action: #selector(updateButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.theme_setBackgroundImage(["version_close_but_bg"], forState: .normal)
        view.addTarget(self, action: #selector(closeButton(_:)), for: UIControlEvents.touchUpInside)
        return view
    }()
    
    var strongSelf:APVersionUpgradeController?
    
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

        view.addSubview(versionUpgradeView)
        view.addSubview(updateButton)
        view.addSubview(closeButton)
        
        versionUpgradeView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(238)
            make.height.equalTo(283)
        }
        updateButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(versionUpgradeView.snp.centerX)
            make.centerY.equalTo(versionUpgradeView.snp.bottom)
            make.left.equalTo(versionUpgradeView.snp.left).offset(30)
            make.right.equalTo(versionUpgradeView.snp.right).offset(-30)
            make.height.equalTo(44)
        }
        closeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(updateButton.snp.centerX)
            make.top.equalTo(updateButton.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 31, height: 31))
        }
    }
    
    func show(version: String, text: String) {
        let window: UIWindow = UIApplication.shared.keyWindow!
        view.frame = window.bounds
        window.addSubview(view)
        window.bringSubview(toFront: view)
        versionUpgradeView.version.text = version
        versionUpgradeView.text.text = text
    }
    
    func diss() {
        view.removeFromSuperview()
        versionUpgradeView.removeFromSuperview()
        strongSelf = nil
    }
    
    @objc func updateButton(_ button: UIButton) {
        
    }
    
    @objc func closeButton(_ button: UIButton) {
        diss()
    }
    
}


//MARK: ---- APVersionUpgradeView

class APVersionUpgradeView: UIView {
    
    var title: UILabel = {
        let view = UILabel()
        view.text = "发现新版本"
        view.textAlignment = .center
        view.theme_textColor = ["#ffc96f"]
        view.font = UIFont.systemFont(ofSize: 36)
        view.backgroundColor = UIColor.clear
        return view
    }()
    var version: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.theme_textColor = ["#ffc96f"]
        view.font = UIFont.systemFont(ofSize: 36)
        view.backgroundColor = UIColor.clear
        return view
    }()
    var text: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.theme_textColor = ["#fff0ce"]
        view.font = UIFont.systemFont(ofSize: 13)
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.layer.contents = UIImage(named: "version_bg")?.cgImage
        backgroundColor = UIColor.clear
        addSubview(title)
        addSubview(version)
        addSubview(text)
        title.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.snp.top).offset(20)
            maker.left.equalTo(self.snp.left).offset(20)
            maker.right.equalTo(self.snp.right).offset(-20)
            maker.height.equalTo(30)
        }
        version.snp.makeConstraints { (maker) in
            maker.top.equalTo(title.snp.bottom).offset(20)
            maker.left.equalTo(self.snp.left).offset(20)
            maker.right.equalTo(self.snp.right).offset(-20)
            maker.height.equalTo(30)
        }
        text.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left).offset(20)
            maker.right.equalTo(self.snp.right).offset(-20)
            maker.top.equalTo(version.snp.bottom).offset(20)
            maker.bottom.equalTo(self.snp.bottom).offset(-40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










