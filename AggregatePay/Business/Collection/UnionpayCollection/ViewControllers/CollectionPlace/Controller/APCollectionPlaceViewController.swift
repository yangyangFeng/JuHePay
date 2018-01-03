//
//  APCollectionPlaceViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/16.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 选择收款通道
 */
class APCollectionPlaceViewController: APUnionPayBaseViewController {
    var datas = [APPlaceModel]()
    let upeTranVC = APUPETranViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择收款通道"
        edgesForExtendedLayout =  UIRectEdge(rawValue: 0)
        view.theme_backgroundColor = ["#fafafa"]
        
        initCreateSubviews()
        startHttpQueryChannelFess()
    }
    
    
    //MARK: ---- lazy loading
    lazy var tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = .none
        view.tableFooterView = UIView()
        view.theme_backgroundColor = ["#fafafa"]
        view.register(APCollectionPlaceCell.self, forCellReuseIdentifier: "APCollectionPlaceCell")
        return view
    }()
}

//MARK: ------- APCollectionPlaceViewController - Extension(网络相关方法)
extension APCollectionPlaceViewController {
    
    //获取费率
    func startHttpQueryChannelFess() {
        let queryChannelFessRequest = APQueryChannelFessRequest()
        view.AP_loadingBegin()
        APNetworking.post(httpUrl: APHttpUrl.trans_httpUrl, action: APHttpService.queryChannelFees, params: queryChannelFessRequest, aClass: APQueryChannelFessResponse.self, success: { (baseResp) in
            self.httpDisposeQueryChannelFess(response: baseResp)
            self.tableView.reloadData()
            self.view.AP_loadingEnd()
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    //获取卡列表（验证是否开通过银联快哦节）
    func startQueryQuickPayCardList() {
        let queryQuickPayCardListRequest = APQueryQuickPayCardListRequest()
        view.AP_loadingBegin()
        APNetworking.get(httpUrl: APHttpUrl.trans_httpUrl,
                         action: APHttpService.queryQuickPayCardList,
                         params: queryQuickPayCardListRequest,
                         aClass: APQueryQuickPayCardListResponse.self,
                         success: { (baseResp) in
                            self.httpDisposequeryQuickPayCardList(response: baseResp)
                            self.view.AP_loadingEnd()
        }, failure: {(baseError) in
            self.view.AP_loadingEnd()
            self.view.makeToast(baseError.message)
        })
    }
    
    private func httpDisposequeryQuickPayCardList(response: APBaseResponse) {
        let result = response as! APQueryQuickPayCardListResponse
        let count : Int = (result.list?.count)!
        if count > 0 {
            upeTranVC.quickCardDetail = result.list?[0]
        }
        self.navigationController?.pushViewController(upeTranVC, animated: true)
    }
    
    private func httpDisposeQueryChannelFess(response: APBaseResponse) {
        let result = response as! APQueryChannelFessResponse
        datas.removeAll()
        let placeModel = APPlaceModel()
        placeModel.integraFlag = "0"
        placeModel.title = "银联快捷收款"
        placeModel.rate = splitFeeInfo(baseFee: result.unionpayBaseFee!,
                                       addD0: result.unionpayAddD0!)
        let placeGitfModel = APPlaceModel()
        placeGitfModel.integraFlag = "1"
        placeGitfModel.title = "银联快捷收款·积分"
        placeGitfModel.rate = splitFeeInfo(baseFee: result.unionpayGiftBaseFee!,
                                           addD0: result.unionpayGiftAddD0!)
        datas.append(placeModel)
        datas.append(placeGitfModel)
    }
}


//MARK: ------- APCollectionPlaceViewController - Extension(私有方法)
extension APCollectionPlaceViewController {
    
    func initCreateSubviews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}


//MARK: ------- APCollectionPlaceViewController - Extension(代理方法)

extension APCollectionPlaceViewController:
    UITableViewDelegate,
    UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collectionPlaceCell: APCollectionPlaceCell = APCollectionPlaceCell.cellWithTableView(tableView) as! APCollectionPlaceCell
        let placeModel = datas[indexPath.row]
        collectionPlaceCell.titleLabel.text = placeModel.title
        collectionPlaceCell.rateLabel.text = placeModel.rate
        return collectionPlaceCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeModel = datas[indexPath.row]
        upeTranVC.totalAmount = totalAmount
        upeTranVC.payPlaceTitle = placeModel.title
        upeTranVC.integraFlag = placeModel.integraFlag
        startQueryQuickPayCardList()
    }
}

extension APCollectionPlaceViewController {
    
    private func splitFeeInfo(baseFee: String, addD0: String) -> String {
        return "费率:"+baseFee+"%+"+addD0
    }
}

class APPlaceModel: NSObject {
    var title: String?
    var rate: String?
    var integraFlag: String?
}






