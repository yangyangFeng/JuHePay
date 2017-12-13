//
//  APBankCardManageListView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

let K_Width = UIScreen.main.bounds.size.width
let K_Height = UIScreen.main.bounds.size.height

class APBankCardManageListView: UIView, UITableViewDataSource, UITableViewDelegate {

    lazy var tableView: UITableView = {
        var view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.tableFooterView = UIView()
        view.backgroundColor = UIColor.black
        view.register(APBankCardCell.self, forCellReuseIdentifier: "APBankCardCell")
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = APBankCardCell.cellWithTableView(tableView)
        return cell!
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        
        let segmentView = APBankCardManageSegmentButton()
        segmentView.segmentBlock =  { index in
            print(index)
        }
        
        addSubview(segmentView)
        addSubview(tableView)
        
        segmentView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { (make) in
//            make.top.equalTo(segmentView.snp.bottom).offset(0)
            make.left.right.bottom.top.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}

typealias AP_SegmentBlock = (_ index : Int)->Void

class APBankCardManageSegmentButton: UIView {
    var buttonLeft = UIButton(type: UIButtonType.custom)
    var buttonRight = UIButton(type: UIButtonType.custom)
    let bottomLine = UIView()
    var segmentBlock : AP_SegmentBlock?
   
    
    override init(frame: CGRect) {
//        super.init()
        super.init(frame: frame)
        theme_backgroundColor = ["#373737"]
        bottomLine.theme_backgroundColor = ["#c8a556"]
        
        buttonLeft.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        buttonLeft.theme_setTitleColor(["#c8a556"], forState: .selected)
        buttonLeft.theme_setTitleColor(["#999999"], forState: .normal)
        buttonLeft.setTitle("信用卡管理", for: UIControlState.normal)
        buttonLeft.theme_backgroundColor = ["#373737"]
        buttonLeft.addTarget(self, action: #selector(leftButtonDidAction), for: UIControlEvents.touchUpInside)
        
        buttonRight.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        buttonRight.theme_setTitleColor(["#c8a556"], forState: .selected)
        buttonRight.theme_setTitleColor(["#999999"], forState: .normal)
        buttonRight.setTitle("结算卡管理", for: UIControlState.normal)
        buttonRight.theme_backgroundColor = ["#373737"]
        buttonRight.addTarget(self, action: #selector(rightButtonDidAction), for: UIControlEvents.touchUpInside)
        
        addSubview(buttonLeft)
        addSubview(buttonRight)
        addSubview(bottomLine)
        
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.left.equalTo(0)
            make.height.equalTo(2)
            make.width.equalTo(snp.width).multipliedBy(0.5)
        }
        buttonLeft.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(0)
            make.width.equalTo(snp.width).multipliedBy(0.5)
        }
        buttonRight.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(0)
            make.width.equalTo(snp.width).multipliedBy(0.5)
        }
    }
    
    @objc func leftButtonDidAction()
    {
        buttonRight.isSelected = false
        buttonLeft.isSelected = true
        if let block = segmentBlock {
            block(0)
            UIView.animate(withDuration: 0.15, animations: {
                self.bottomLine.snp.updateConstraints({ (make) in
                    make.bottom.left.equalTo(0)
                    make.height.equalTo(2)
                    make.width.equalTo(self.snp.width).multipliedBy(0.5)
                })
                self.layoutIfNeeded()
                
            }, completion: { (state) in
                
            })
        }
    }
    
    @objc func rightButtonDidAction()
    {
        buttonRight.isSelected = true
        buttonLeft.isSelected = false
        if let block = segmentBlock {
            
            block(1)
            UIView.animate(withDuration: 0.15, animations: {
                self.bottomLine.snp.updateConstraints({ (make) in
                    make.bottom.equalTo(0)
                    make.height.equalTo(2)
                    make.width.equalTo(self.snp.width).multipliedBy(0.5)
                    make.left.equalTo(K_Width/2.0)
                })
                self.layoutIfNeeded()
                
            }, completion: { (state) in
                
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class APBankCardCell: UITableViewCell {
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APBankCardCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "BankCardBG"))
        
        let delButton = UIButton(type: .system)
        delButton.backgroundColor = UIColor.clear
        delButton.setBackgroundImage(UIImage.init(named: "BankCard_Del"), for: UIControlState.normal)
        delButton.addTarget(self, action: #selector(buttonDidAction), for: UIControlEvents.touchUpInside)
        
        let bgView = UIView()
        
        bgView.backgroundColor = UIColor.clear
        bgView.addSubview(delButton)
        contentView.addSubview(bgView)
        contentView.addSubview(bgImageView)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
        }
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(K_Width)
            make.top.bottom.equalTo(0)
            make.width.equalTo(K_Width)
        }
        delButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(bgView.snp.centerY).offset(0)
            make.left.equalTo(0)
            make.width.height.equalTo(50)
        }
        
    }
//    override var frame:CGRect{
//        didSet {
//
//            var newFrame = frame
//            newFrame.origin.x += 20
//            newFrame.size.width -= 40
//            newFrame.origin.y += 10
//            newFrame.size.height -= 10
//            super.frame = newFrame
//
//        }
//    }
  
    @objc func buttonDidAction()
    {
        print("删除")
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
