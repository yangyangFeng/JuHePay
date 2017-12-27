//
//  APLoadingUtils.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

extension UIView{
    func AP_loadingBegin(){
        AP_loadingBegin("加载中")
    }
    func AP_loadingBegin(_ title : String){
        showToast(APLoadingView.init(title), duration: TimeInterval(HUGE), point: center, completion: nil)
    }
    func AP_loadingEnd(){
        self.hideAllToasts()
    }
}

class APLoadingView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageIcon = UIImage.init(named: "AP_Loading")
        var view = UIImageView.init(image: imageIcon)
        view.frame = CGRect.init(x: 0, y: 0, width: (imageIcon?.size.width)!, height: (imageIcon?.size.height)!)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        var view = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 20))
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.init(hex6: 0xffffff)
        view.text = loading_title
        return view
    }()
    
    var loading_title = "加载中" {
        willSet{
            titleLabel.text = newValue
        }
    }
    
    
    convenience init(_ title : String) {
        self.init(frame: CGRect.zero)
        titleLabel.text = title
        frame = viewSize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: viewSize())
        layer.masksToBounds = true
        layer.cornerRadius = 8
        backgroundColor = UIColor.init(hex6: 0x000000, alpha: 0.7)
        print(self)
        addAnimation(imageView.layer)
        addSubview(imageView)
        addSubview(titleLabel)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(18)
            make.centerY.equalTo(snp.centerY).offset(0)
            make.left.equalTo(15)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalTo(snp.centerY).offset(0)
        }
    }

    func viewSize() -> CGRect{
        return CGRect.init(x: 0, y: 0, width: imageView.width + titleLabel.requiredWidth + 40, height: 52)
    }
    
    func addAnimation(_ layer : CALayer){
        AP_addRotatingAnimation(layer)
    }
    
    func removeAnimation(_ layer : CALayer){
        AP_removeRotatingAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
