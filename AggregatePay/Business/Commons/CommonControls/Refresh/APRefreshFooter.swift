//
//  APRefreshFooter.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import MJRefresh
class APRefreshFooter: MJRefreshAutoStateFooter {

    override var state: MJRefreshState {
        willSet{
            switch newValue {
            case .idle:
                AP_imageView.alpha = 1
                AP_imageView.AP_removeRotatingAnimation()
                break
            case .pulling:
                AP_imageView.alpha = 1
                AP_imageView.AP_removeRotatingAnimation()
                break
            case .refreshing:
                AP_imageView.alpha = 1
                AP_imageView.AP_addRotatingAnimation(AP_imageView.layer)
                break
            case .noMoreData:
                AP_imageView.AP_removeRotatingAnimation()
                AP_imageView.alpha = 0
                break
            default:
                break
            }
        }
    }
    
    lazy var AP_imageView: UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "AP_Loading"))
        view.size = CGSize.init(width: (view.image?.size.width)!*AP_RefreshConfig.footerImageScale, height: view.size.height*AP_RefreshConfig.footerImageScale)
        view.backgroundColor = UIColor.clear
        return view
    }()

    lazy var refreshFooterView: UIView = {
        let view = UIView.init(frame: self.bounds)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    override var stateLabel: UILabel! {
        set{
            
        }
        get{
            super.stateLabel.font = UIFont.systemFont(ofSize: 12)
            super.stateLabel.textColor = UIColor.init(hex6: AP_RefreshConfig.titleColor)
            return super.stateLabel
        }
    }
    
    override func prepare() {
        super.prepare()
        mj_h = AP_RefreshConfig.footerHeight
        isAutomaticallyHidden = true
        addSubview(AP_imageView)
        
        
        setTitle("下拉加载更多", for: .idle)
        setTitle("松开立即刷新", for: .pulling)
        setTitle("正在加载更多", for: .refreshing)
        setTitle("已是最后", for: .noMoreData)
    }

    override func placeSubviews() {
        super.placeSubviews()
        refreshFooterView.frame = bounds
        AP_imageView.center = CGPoint.init(x: (K_Width - stateLabel.mj_textWith() - (AP_imageView.width))/2.0 - 7, y: mj_h/2.0)
    }
}
