//
//  APSelectMerchantViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 *选择商户类型页面
 */
class APQRCPSeleMerchantViewController: APQRCPBaseViewController{

    let merchantCategoryRequest = APMerchantCategoryRequest()
    
    var selectModel: APMerchantDetail?
    
    let defaultModel: APMerchantDetail = APMerchantDetail()
    
    var datas = [APMerchantDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择商户类型"
        view.theme_backgroundColor = ["#fafafa"]
        createSubViews()
        initHttpRequest()
    }
   
    
    //MARK: --- lazy loading
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.AP_setupEmpty()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APSelectMerchantCell.self,
                      forCellReuseIdentifier: "APSelectMerchantCell")
        return view
    }()
}

//MARK: ---- private

extension APQRCPSeleMerchantViewController {
    
    private func createSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func initHttpRequest() {
        weak var weakSelf = self
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.datas.removeAll()
            weakSelf?.startHttpMerchantCategory()
        })
        view.AP_loadingBegin()
        startHttpMerchantCategory()
    }
    
    private func startHttpMerchantCategory() {
        merchantCategoryRequest.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        merchantCategoryRequest.type = self.payType!
        APNetworking.get(httpUrl: APHttpUrl.trans_httpUrl,
                         action: APHttpService.merchantCategory,
                         params: merchantCategoryRequest,
                         aClass: APMerchantCategoryResponse.self,
                         success: { (baseResp) in
                            let result = baseResp as! APMerchantCategoryResponse
                            self.datas.append(contentsOf: result.list!)
                            self.tableView.mj_header.endRefreshing()
                            self.tableView.reloadData()
                            self.view.AP_loadingEnd()
        }, failure: {(baseError) in            
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
}

//MARK: ---- delegate

extension APQRCPSeleMerchantViewController:
    UITableViewDelegate,
    UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectMerchantCell: APSelectMerchantCell = APSelectMerchantCell.cellWithTableView(tableView) as! APSelectMerchantCell
        let model: APMerchantDetail = datas[indexPath.row] as APMerchantDetail
        selectMerchantCell.merchatDetail(model: model, selectModel: (selectModel ?? defaultModel)!)
        return selectMerchantCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if datas.count > 0 {
            let model: APMerchantDetail = datas[indexPath.row] as APMerchantDetail
            NotificationCenter.default.post(Notification.init(name: NOTIFICA_SELECT_MERCHANT_KEY,
                                                              object: model,
                                                              userInfo: nil))
            navigationController?.popViewController(animated: true)
        }
    }
    
}




