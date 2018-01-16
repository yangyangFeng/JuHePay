//
//  APBaseWebViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/5.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit
import WebKit

class APBaseWebViewController: APBaseViewController{

    public var urlService : String?
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCreateSubViews()
        registerObserver()
        loadHtmlRequest()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" && object is WKWebView {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.25,
                               delay: 0.1,
                               options: .curveEaseOut,
                               animations: {
                                
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
        else if keyPath == "title" && object is WKWebView {
            title = webView.title
        }
        else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
        }
    }
    
    //MARK: Public
    public func ap_url() -> String {
        return urlService!
    }
    
    //MARK: Lazy Loading
    lazy private var webView: WKWebView = {
        self.webView = WKWebView(frame: CGRect.zero)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        return self.webView
    }()
    
    lazy var progressView: UIProgressView = {
        self.progressView = UIProgressView(frame: CGRect.zero)
        self.progressView.tintColor = UIColor(hex6: 0xc8a556)
        self.progressView.trackTintColor = UIColor.groupTableViewBackground
        return self.progressView
    }()
}

//MARK: ---------- APBaseWebViewController - Extension(私有方法)

extension APBaseWebViewController {
    
    private func initCreateSubViews() {
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(webView.snp.top)
            make.left.right.equalTo(webView)
            make.height.equalTo(2)
        }
    }
    
    private func registerObserver() {
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    private func loadHtmlRequest() {
        let urlStr = APHttpUrl.manange_httpUrl + ap_url()
        webView.load(URLRequest.init(url: URL.init(string: urlStr)!))
    }
}

//MARK: ---------- APBaseWebViewController - Extension(代理方法)

extension APBaseWebViewController:
    WKNavigationDelegate,
    WKUIDelegate  {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("开始获取网页内容")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}




