//
//  APSearchBarView.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

public protocol APSearchBarViewDelegate: NSObjectProtocol {
    
    func searchButtonDidTap()
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
        
        textField.backgroundColor = UIColor.white
        textField.layer.theme_borderColor = ["efefef"]
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.leftView = imageView
        
        let searchButton = UIButton()
        searchButton.theme_setBackgroundImage(["auth_search_button"], forState: .normal)
        searchButton .addTarget(self, action: #selector(search), for: UIControlEvents.touchUpInside)
        
        addSubview(textField)
        addSubview(searchButton)
        
        searchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(9)
            make.bottom.top.equalToSuperview()
            make.width.equalTo(50)
        }
        textField.snp.makeConstraints { (make) in
            make.right.equalTo(searchButton.snp.left).offset(10)
            make.top.bottom.left.equalToSuperview()
            
        }
    }
    
    @objc func search() {
        delegate?.searchButtonDidTap()
    }
    @objc func textDidChange() {
        
    }

}
