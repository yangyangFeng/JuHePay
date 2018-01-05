//
//  APEarningsViewController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
/**
 * 收益
 */
class APEarningsViewController: APBaseViewController,AP_TableViewDidSelectProtocol {

    var data : APGetProfitHomeResponse?
    
    let headView = APEarningHeadView.init(frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 140.0))
    
    
    let listView = APEarningListView.init(frame: CGRect.init(x: 0, y: 0, width: K_Width, height: K_Height-64))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "收益"
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        
        initSubviews()
        
        loadData()
    }
    
    func loadData()
    {
        let param = APGetProfitHomeRequest()
        param.mobileNo = APUserDefaultCache.AP_get(key: .mobile) as? String
        
        APEarningsHttpTool.getProfitHome(param, success: { (res) in
            self.listView.tableView.mj_header.endRefreshing()
            self.data = res as? APGetProfitHomeResponse
            self.updateSubviews(res as! APGetProfitHomeResponse)
        }) { (error) in
            self.listView.tableView.mj_header.endRefreshing()
        }
    }

    func updateSubviews(_ data : APGetProfitHomeResponse){
        headView.data = data
        listView.data = data
    }
    
    func AP_Action_Click()
    {
        guard let tempData = data else {
            self.loadData()
            return
        }
        let returnBillC = APReturnBillViewController()
        returnBillC.data = tempData
        navigationController?.pushViewController(returnBillC)
    }
    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        let cellData : APGetProfitHomeResponse = obj as! APGetProfitHomeResponse
        let agentDetailC = APAgentDetailViewController()
        agentDetailC.title = cellData.userLevelName
        agentDetailC.data = cellData
        navigationController?.pushViewController(agentDetailC)
    }
    
    func initSubviews()
    {
        let image = UIImage.init(named: "Earning_head_bg")
        self.vhl_setNavBarBackgroundImage(image?.cropped(to: 64.0/204.0))
        
        headView.delegate = self
        listView.delegate = self
        listView.tableView.tableHeaderView = headView
        view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        weak var weakSelf = self
        listView.tableView.mj_header = APRefreshHeader(refreshingBlock: {
            weakSelf?.loadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
