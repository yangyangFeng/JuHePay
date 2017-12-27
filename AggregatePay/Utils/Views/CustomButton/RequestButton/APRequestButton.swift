//
//  APRequestButton.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APLoadingCompleteBlock = () -> Void

class APRequestButton: UIButton {
    
    deinit {
        print("APRequestButton ------- 已释放")
    }
    
    var loadingCompleteBlock: APLoadingCompleteBlock?
    
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var isLoading = false {
        willSet {
            let lastView: UIView = (appDelegate.window?.subviews.last!)!
            if isLoading {
                activityIndicator.stopAnimating()
                self.setTitle(self.currentTitle, for: .disabled)
            }
            else {
                activityIndicator.startAnimating()
                self.setTitle("", for: .disabled)
            }
            lastView.isUserInteractionEnabled = newValue
            self.isEnabled = newValue
            self.loadingCompleteBlock?()
        }
    }
    
    var activityIndicator = UIActivityIndicatorView()

    init() {
        super.init(frame: CGRect.zero)
        activityIndicator.activityIndicatorViewStyle = .white
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loading(isLoad: Bool, isComplete complete:@escaping APLoadingCompleteBlock) {
        loadingCompleteBlock = complete
        isLoading = isLoad
    }

    
}
