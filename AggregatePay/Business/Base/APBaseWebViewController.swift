//
//  APBaseWebViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/5.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

class APBaseWebViewController: APBaseViewController,UIWebViewDelegate {

    var url : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        webView.loadRequest(URLRequest.init(url: URL.init(string: url!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var webView : UIWebView = {
        let view = UIWebView()
        view.delegate = self
        return view
    }()

    func webViewDidStartLoad(_ webView: UIWebView) {
        view.AP_loadingBegin()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        view.AP_loadingEnd()
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
