//
//  APReturnBillViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APReturnBillViewController: APBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        // Do any additional setup after loading the view.
    }
    
    func initSubviews(){
        let searchBar = APReturnBillSearchBar()
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(104)
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
