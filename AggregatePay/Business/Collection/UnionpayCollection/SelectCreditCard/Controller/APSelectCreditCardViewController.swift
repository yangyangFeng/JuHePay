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
        
        weak var weakSelf = self
        tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.datas.removeAll()
            weakSelf?.queryQuickPayCardListRequest.pageNo = 1
            weakSelf?.startQueryQuickPayCardList()
        })
        tableView.mj_footer = APRefreshFooter(refreshingBlock: {
            weakSelf?.startQueryQuickPayCardList()
        })
        datas.removeAll()
        queryQuickPayCardListRequest.pageNo = 1
        view.AP_loadingBegin()
        startQueryQuickPayCardList()
    }
    

    //获取卡列表（验证是否开通过银联快哦节）
    func startQueryQuickPayCardList() {
        
        view.AP_loadingBegin()
        APNetworking.get(httpUrl: APHttpUrl.trans_httpUrl, action: APHttpService.queryQuickPayCardList, params: queryQuickPayCardListRequest, aClass: APQueryQuickPayCardListResponse.self, success: { (baseResp) in
            self.view.AP_loadingEnd()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.httpDisposequeryQuickPayCardList(response: baseResp as! APQueryQuickPayCardListResponse)
        }, failure: {(baseError) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    private func httpDisposequeryQuickPayCardList(response: APQueryQuickPayCardListResponse) {

        if queryQuickPayCardListRequest.pageNo >= Int(response.bottomPageNo!)! {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        queryQuickPayCardListRequest.pageNo = queryQuickPayCardListRequest.pageNo+1
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
        let cardNo = aesDecryptString(detail.cardNo, UNION_AES_CARD_KEY)
        selectCreditCardCell.cardLastNo.text = cardNo
        selectCreditCardCell.titleLabel.text = detail.bankName
        selectCreditCardCell.cardTypeLabel.text = detail.realName
        return selectCreditCardCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if datas.count > 0 {
            let detail = datas[indexPath.row]
            detail.cardNo = aesDecryptString(detail.cardNo,UNION_AES_CARD_KEY)
            NotificationCenter.default.post(Notification.init(name: TRAN_CARD_NOTIF_KEY,
                                                              object: detail,
                                                              userInfo: nil))
            navigationController?.popViewController(animated: true)
        }
    }
}










