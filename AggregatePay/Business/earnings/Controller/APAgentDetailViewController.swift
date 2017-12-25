//
//  APAgentDetailViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAgentDetailViewController: APBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        
//        view.AP_loadingBegin()
        view.AP_loadingBegin("阿斯蒂芬好的干是经过和的放假")
        // Do any additional setup after loading the view.
    }
    
    func initSubviews(){
        let segment = APSegmentControl.init(["直接推广", "间接推广"], frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 40))
        segment.theme_backgroundColor = [AP_TableViewBackgroundColor]
        segment.segmentBlock = { index in
            
        }
        
        view.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        let listView = APAgentDetailListView()
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.top.equalTo(segment.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
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
