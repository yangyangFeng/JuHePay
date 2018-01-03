//
//  APSearchBarView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

public protocol APSearchBarViewDelegate: NSObjectProtocol {
    
    func searchButtonDidTap(keyword: String)
}

class APSearchBarView: UIView, UITextFieldDelegate {

    public weak var delegate: APSearchBarViewDelegate?
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("can load nib")
    }
    
    private func layoutViews() {
        
        let imageView = UIImageView()
        imageView.theme_image = ["auth_search_image"]
        imageView.contentMode = .center
        let imageViewBgView = UIView()
        imageViewBgView.backgroundColor = UIColor.clear
        
        textField.backgroundColor = UIColor.white
        textField.layer.theme_borderColor = ["#efefef"]
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.leftView = imageViewBgView
        textField.leftViewMode = .always
        textField.leftView?.width = 40
        textField.leftView?.height = 30
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.setPlaceHolderTextColor(UIColor.init(hex6: 0x999999))
        
        let searchButton = UIButton()
        searchButton.theme_setBackgroundImage(["auth_search_button"], forState: .normal)
        searchButton .addTarget(self, action: #selector(search), for: UIControlEvents.touchUpInside)
        
        imageViewBgView.addSubview(imageView)
        addSubview(textField)
        addSubview(searchButton)
        
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        searchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.top.equalToSuperview()
        }
        textField.snp.makeConstraints { (make) in
            make.right.equalTo(searchButton.snp.left).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        
        searchButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    @objc func search() {
        endEditing(true)
        delegate?.searchButtonDidTap(keyword: textField.text!)
    }
    @objc func textDidChange() {
        
    }

}
