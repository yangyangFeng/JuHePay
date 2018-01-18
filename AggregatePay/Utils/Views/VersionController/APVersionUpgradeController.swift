//
//  APVersionUpgradeController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

//MARK:  APVersionUpgradeController

extension APVersionUpgradeController {
    
    static func show(minVersion: String,
                     maxVersion: String,
                     content:String,
                     storeUrl: String) {
        if minVersion == "" || maxVersion == "" || content == "" || storeUrl == "" {
            return
        }
        APVersionUpgradeController().show(minVersion: minVersion,
                                          maxVersion: maxVersion,
                                          content: content,
                                          storeUrl: storeUrl)
    }
}

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
    
    var updateStoreUrl: String?
    
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
    
    func show(minVersion: String,
              maxVersion: String,
              content:String,
              storeUrl: String)  {
        if isUpdate(minVersion: minVersion, maxVersion: maxVersion) {
            let window: UIWindow = UIApplication.shared.keyWindow!
            view.frame = window.bounds
            window.addSubview(view)
            window.bringSubview(toFront: view)
            updateStoreUrl = storeUrl
            versionUpgradeView.version.text = maxVersion
            versionUpgradeView.text.text = content
        }
    }
    
    func isUpdate(minVersion: String, maxVersion: String) -> Bool {
        let currentVersion_Int = replacing(versionNo: AppVersion as! String)
        let minVersion_Int = replacing(versionNo: minVersion)
        let maxVersion_Int = replacing(versionNo: maxVersion)
        
        if currentVersion_Int < minVersion_Int {
            //如果当前版本小于最小版本则强制升级
            closeButton.isHidden = true
            return true
        }
        else if currentVersion_Int >= minVersion_Int &&
                currentVersion_Int < maxVersion_Int {
            //如果当前版本大于等于最小版本并且小于最大版本则非强制升级
            closeButton.isHidden = false
            return true
        }
        else {
            return false
        }
    }
    
    func replacing(versionNo: String) -> Int {
        var versionStr = versionNo
        if versionStr.contains(".") {
            versionStr = versionStr.replacingOccurrences(of: ".", with: "")
        }
        return Int(versionStr)!
    }
    
    func diss() {
        view.removeFromSuperview()
        versionUpgradeView.removeFromSuperview()
        strongSelf = nil
        updateStoreUrl = nil
    }
    
    @objc func updateButton(_ button: UIButton) {
        let app_url : URL = URL.init(string: updateStoreUrl!)!
        if UIApplication.shared.canOpenURL(app_url) {
            UIApplication.shared.openURL(app_url)
        }
    }
    
    @objc func closeButton(_ button: UIButton) {
        diss()
    }
    
}


//MARK: ---- APVersionUpgradeView

class APVersionUpgradeView: UIView {
    
   lazy var title: UILabel = {
        let view = UILabel()
        view.text = "发现新版本"
        view.textAlignment = .center
        view.theme_textColor = ["#ffc96f"]
        view.font = UIFont.systemFont(ofSize: 36)
        view.backgroundColor = UIColor.clear
        return view
    }()
    lazy var version: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.theme_textColor = ["#ffc96f"]
        view.font = UIFont.systemFont(ofSize: 36)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var text: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.textAlignment = .left
        view.theme_textColor = ["#fff0ce"]
        view.font = UIFont.systemFont(ofSize: 13)
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










