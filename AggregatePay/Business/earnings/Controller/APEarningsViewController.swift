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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "收益"
        vhl_setNavBarTitleColor(UIColor(hex6: 0x7F5E12))
        initSubviews()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData()
    {
        let param = APGetProfitHomeRequest()
        param.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        param.mobileNo = APUserInfoTool.info.mobileNo
        
        APEarningsHttpTool.getProfitHome(param, success: { (res) in

        }) { (error) in

        }
    }

    func AP_Action_Click()
    {
        let returnBillC = APReturnBillViewController()
        navigationController?.pushViewController(returnBillC)
    }
    
    func AP_TableViewDidSelect(_ indexPath: IndexPath, obj: Any) {
        let title = obj
        let agentDetailC = APAgentDetailViewController()
        agentDetailC.title = title as? String
        navigationController?.pushViewController(agentDetailC)
    }
    
    func initSubviews()
    {
        let image = UIImage.init(named: "Earning_head_bg")
        self.vhl_setNavBarBackgroundImage(image?.cropped(to: 64/204))
        
        let headView = APEarningHeadView.init(frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 140))
        headView.delegate = self
        
        let listView = APEarningListView.init(frame: CGRect.init(x: 0, y: 0, width: K_Width, height: K_Height-64))
        listView.delegate = self
        listView.tableView.tableHeaderView = headView
        view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
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
