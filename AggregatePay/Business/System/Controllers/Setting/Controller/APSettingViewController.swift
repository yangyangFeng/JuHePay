//
//  APSettingViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSettingViewController: APBaseViewController {
    
    let loginOutRequest = APLoginOutRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(submitCell)
        view.addSubview(tableView)
        
        submitCell.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(41)
        }
        
        tableView.snp.makeConstraints { (maker) in
            maker.left.top.right.equalTo(view)
            maker.bottom.equalTo(submitCell.snp.top).offset(-50)
        }
        
        weak var weakSelf = self
        submitCell.buttonBlock = { (key, value) in
            weakSelf?.alertLoginOut()
        }
    }
    
    //MARK: ---- lzay loading
    lazy var submitCell: APSubmitFormsCell = {
        let view = APSubmitFormsCell()
        view.button.setTitle("退出登录", for: .normal)
        return view
    }()
    
    
    lazy var titles : NSArray = {
        var arr : NSArray = NSArray(array: ["修改密码",
                                            "找回密码"])
        return arr
    }()
    
    lazy var describes : NSArray = {
        var arr : NSArray = NSArray(array: ["建议您定期更改密码以保护账户安全",
                                            "若忘记密码可以通过找回密码找回"])
        return arr
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APSettingCell.self, forCellReuseIdentifier: "APSettingCell")
        return view
    }()
}

extension APSettingViewController {
    
    func alertLoginOut() {
        APAlertManager.show(param: { (param) in
            param.apMessage = "是否退出当前登录"
            param.apConfirmTitle = "退出登录"
            param.apCanceTitle = "取消"
        }, confirm: { (confirmAction) in
            self.httpLoginOut()
        }, cancel: {(cancel) in
        })
    }
    
    func httpLoginOut() {
        loginOutRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        submitCell.loading(isLoading: true, isComplete: nil)
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl,
                          action: APHttpService.logout,
                          params: loginOutRequest,
                          aClass: APBaseResponse.self, success: { (baseResp) in
                            self.submitCell.loading(isLoading: false, isComplete: nil)
                            APOutLoginTool.loginOut()
        }, failure: { (baseError) in
            self.submitCell.loading(isLoading: false, isComplete: nil)
            self.view.makeToast(baseError.message)
        })
    }
}

extension APSettingViewController:
    UITableViewDelegate,
    UITableViewDataSource {
    //MARK: ---- 代理
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell: APSettingCell = APSettingCell.cellWithTableView(tableView) as! APSettingCell
        settingCell.titleLabel.text = titles.object(at: indexPath.row) as? String
        settingCell.describeLabel.text = describes.object(at: indexPath.row) as? String
        return settingCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(APModifyViewController(), animated: true)
        }
        else if indexPath.row == 1 {
            navigationController?.pushViewController(APForgetFirstStepViewController(), animated: true)
        }
    }
}











