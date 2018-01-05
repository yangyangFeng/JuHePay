//
//  APSelectCreditCardViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit


/**
 * 选择信用卡
 */
class APSelectCreditCardViewController: APUnionPayBaseViewController  {

    let queryQuickPayCardListRequest = APQueryQuickPayCardListRequest()
    
    var datas = [APQueryQuickPayCardDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择银行卡"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            self.datas.removeAll()
            self.queryQuickPayCardListRequest.pageNo = "1"
            self.startQueryQuickPayCardList()
        })
        tableView.mj_footer = APRefreshFooter(refreshingBlock: {
            self.startQueryQuickPayCardList()
        })
        datas.removeAll()
        queryQuickPayCardListRequest.pageNo = "1"
        view.AP_loadingBegin()
        startQueryQuickPayCardList()
    }
    

    //获取卡列表（验证是否开通过银联快哦节）
    func startQueryQuickPayCardList() {
        
        view.AP_loadingBegin()
        APNetworking.get(httpUrl: APHttpUrl.trans_httpUrl, action: APHttpService.queryQuickPayCardList, params: queryQuickPayCardListRequest, aClass: APQueryQuickPayCardListResponse.self, success: { (baseResp) in
            self.httpDisposequeryQuickPayCardList(response: baseResp as! APQueryQuickPayCardListResponse)
            self.view.AP_loadingEnd()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }, failure: {(baseError) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    private func httpDisposequeryQuickPayCardList(response: APQueryQuickPayCardListResponse) {
        if queryQuickPayCardListRequest.pageNo == response.totalRecords {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        queryQuickPayCardListRequest.pageNo = response.bottomPageNo!
        datas.append(contentsOf: response.list!)
        tableView.reloadData()
    }
    
    //MARK: ---- lazy loading
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.AP_setupEmpty()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APSelectCreditCardCell.self,
                      forCellReuseIdentifier: "APSelectCreditCardCell")
        return view
    }()

}

extension APSelectCreditCardViewController:
    UITableViewDelegate,
    UITableViewDataSource {
    
    //MARK: ---- delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectCreditCardCell: APSelectCreditCardCell = APSelectCreditCardCell.cellWithTableView(tableView) as! APSelectCreditCardCell
        let detail: APQueryQuickPayCardDetail = datas[indexPath.row]
        selectCreditCardCell.titleLabel.text = detail.bankName
        selectCreditCardCell.cardLastNo.text = detail.cardNo
        selectCreditCardCell.cardTypeLabel.text = detail.realName
        return selectCreditCardCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail: APQueryQuickPayCardDetail = datas[indexPath.row]
        let model = APQuickCardInfoModel()
        model.realName = detail.realName!
        model.cardNo = detail.cardNo!
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: TRAN_NOTIFICATION_KEY), object: model, userInfo: nil))
        navigationController?.popViewController(animated: true)
    }
}










