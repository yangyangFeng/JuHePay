//
//  APRefreshHeader.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import MJRefresh

struct AP_RefreshConfig {
    static var headerHeight : CGFloat = 40
    static var footerHeight : CGFloat = 40
    static var headerImageScale : CGFloat = 1
    static var footerImageScale : CGFloat = 1
    static var titleColor : UInt32 = 0x4c370b
}

class APRefreshHeader: MJRefreshStateHeader {

    override var state: MJRefreshState {
        willSet{
            switch newValue {
            case .idle:
                AP_imageView.AP_removeRotatingAnimation()
                break
            case .pulling:
                AP_imageView.AP_removeRotatingAnimation()
                break
            case .refreshing:
                AP_imageView.AP_addRotatingAnimation(AP_imageView.layer)
                break
            default:
                break
            }
        }
    }
    
    lazy var AP_imageView: UIImageView = {
        let view = UIImageView.init(image: UIImage.init(named: "AP_Loading"))
        view.size = CGSize.init(width: 18, height: 18)
            //CGSize.init(width: (view.image?.size.width)!*AP_RefreshConfig.headerImageScale, height: view.size.height*AP_RefreshConfig.headerImageScale)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override var stateLabel: UILabel! {
        set{
            
        }
        get{
            super.stateLabel.font = UIFont.systemFont(ofSize: 12)
            super.stateLabel.textColor = UIColor.init(hex6: AP_RefreshConfig.titleColor)
            super.stateLabel.text = super.stateLabel.text ?? "下拉可以刷新"
            return super.stateLabel
        }
    }
    
    override func prepare() {
        super.prepare()
        
        
        mj_h = AP_RefreshConfig.headerHeight
        
        let centerX : CGFloat = (stateLabel.requiredWidth + (AP_imageView.image?.size.width)!)/2.0 + 7

        lastUpdatedTimeLabel.isHidden = true
        addSubview(AP_imageView)
        AP_imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.centerY).offset(0)
            make.centerX.equalTo(snp.centerX).offset(-centerX)
        }
        
        print(stateLabel.requiredWidth)
        setTitle("下拉可以刷新", for: .idle)
        setTitle("松开立即刷新", for: .pulling)
        setTitle("加载中.....", for: .refreshing)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
//        AP_imageView.center = CGPoint.init(x: (K_Width - stateLabel.requiredWidth - (AP_imageView.width))/2.0 - 7, y: mj_h/2.0)
//        print(AP_imageView.center)
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
        
        let newValue = change["new"] as! CGPoint
        let oldValue = change["old"] as! CGPoint
        let radians : CGFloat = fabs(newValue.y) - fabs(oldValue.y)
        AP_imageView.rotate(toAngle: (radians)/8, ofType: AngleUnit.radians)
    }
}
