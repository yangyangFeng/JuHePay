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
class APEarningsViewController: APBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "收益"
        
        initSubviews()
        // Do any additional setup after loading the view.
    }

    func initSubviews()
    {
//        self.vhl_setNavBarBackgroundImage(UIImage.init(named: "Earning_head_bg"))
        self.vhl_setNavBarBackgroundAlpha(0)
        
        let navImageView = UIImageView.init(image: UIImage.init(named: "Earning_head_bg"))

        view.addSubview(navImageView)
        navImageView.snp.makeConstraints { (make) in
            make.top.equalTo(vhl_navigationBarAndStatusBarHeight())
            make.height.equalTo(140)
            make.left.right.equalTo(0)
        }
        
        let headView = APEarningHeadView()
        view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(vhl_navigationBarAndStatusBarHeight())
            make.left.right.equalTo(0)
            make.height.equalTo(140)
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
