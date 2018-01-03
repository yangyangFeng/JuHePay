//
//  APAgentDetailViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAgentDetailViewController: APBaseViewController {

    var data : APGetProfitHomeResponse?
    
    let listView = APAgentDetailListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        
        loadData(0)
        // Do any additional setup after loading the view.
    }
    
    func initSubviews(){
        
        let segment = APSegmentControl.init(["直接推广", "间接推广"], frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 40))
        segment.theme_backgroundColor = [AP_TableViewBackgroundColor]
        weak var weakSelf = self
        segment.segmentBlock = { index in
            weakSelf?.loadData(index)
        }
        
        view.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.top.equalTo(segment.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
        }
    }

    func loadData(_ index : Int){
        view.AP_loadingBegin()
        
        let param = APGetUserListRecommendRequest()
//        param.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        param.type = String(index)
        param.levelId = data?.levelId


        APEarningsHttpTool.getUserListRecommend(param, success: { (res) in
            self.view.AP_loadingEnd()
            let data :APGetUserListRecommendResponse = res as! APGetUserListRecommendResponse
            self.listView.title = self.title
            self.listView.dataSource = data.list
        }) { (error) in
            self.view.AP_loadingEnd()
            self.view.makeToast(error.message)
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
