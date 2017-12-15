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

class APBankCardManageListView: UIView, UITableViewDataSource, UITableViewDelegate, APBankCardCellDelegate {
    
    var rows : Int = 10
    let cellHeight : CGFloat = 110
    
    lazy var tableView: UITableView = {
        var view = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self;
        view.dataSource = self;
        view.tableFooterView = UIView()
        view.backgroundColor = UIColor.black
        view.register(APBankCardCell.self, forCellReuseIdentifier: "APBankCardCell")
        view.separatorStyle = .none
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : APBankCardCell = APBankCardCell.cellWithTableView(tableView) as! APBankCardCell
        cell.delegate = self
//        let swipeCell : BWSwipeRevealCell = cell as! BWSwipeRevealCell
//        swipeCell.delegate = self as BWSwipeRevealCellDelegate
//        swipeCell.threshold = 70
        return cell
        
    }
    
    func swipeCellDelButtonAction(_ cell: UITableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        
        rows -= 1
        tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.right)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cells = tableView.visibleCells
        for cell in cells
        {
            (cell as! APBankCardCell).resetFrame()
        }
        
    }
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        
        let segmentView = APBankCardManageSegmentButton()
        segmentView.segmentBlock =  { index in
            if index == 0 {
                self.rows = 5
                self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.left)
            }
            else
            {
                self.rows = 1
                self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.right)
            }
            
           
        }
        
        addSubview(segmentView)
        addSubview(tableView)
        
        segmentView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
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
        if buttonLeft.isSelected == true {
            return
        }
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
        if buttonRight.isSelected == true {
            return
        }
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
protocol APBankCardCellDelegate : NSObjectProtocol{
    func swipeCellDelButtonAction(_ cell : UITableViewCell)
}
//#makr - 
class APBankCardCell: APSwipeTableViewCell {
    
    weak var delegate : APBankCardCellDelegate?
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APBankCardCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    var bankName : UILabel!
    var userName : UILabel!
    var bankNumber : UILabel!
    var rightMsg : UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "BankCardBG"))
        
        let delButton = UIButton(type: .system)
        delButton.backgroundColor = UIColor.clear
        delButton.setBackgroundImage(UIImage.init(named: "BankCard_Del"), for: UIControlState.normal)
        delButton.addTarget(self, action: #selector(buttonDidAction), for: UIControlEvents.touchUpInside)
        
        swipeContentView.addSubview(bgImageView)
        contentView.addSubview(delButton)
        
        bankName = UILabel()
        bankName.theme_textColor = ["#4c370b"]
        bankName.font = UIFont.systemFont(ofSize: 14)
        bankName.textAlignment = .left
        
        userName = UILabel()
        userName.theme_textColor = ["#4c370b"]
        userName.font = UIFont.systemFont(ofSize: 12)
        userName.textAlignment = .left
        
        bankNumber = UILabel()
        bankNumber.theme_textColor = ["#422f02"]
        bankNumber.font = UIFont.systemFont(ofSize: 18)
        bankNumber.textAlignment = .left
        
        rightMsg = UILabel()
        rightMsg.theme_textColor = ["#4c370b"]
        rightMsg.font = UIFont.systemFont(ofSize: 12)
        rightMsg.textAlignment = .right
        
        bankName.text = "招商银行 信用卡"
        userName.text = "张三"
        bankNumber.text = "**** **** **** 3451"
        rightMsg.text = "快捷"
    
        bgImageView.addSubview(bankName)
        bgImageView.addSubview(userName)
        bgImageView.addSubview(bankNumber)
        bgImageView.addSubview(rightMsg)
        
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
        }

        delButton.snp.makeConstraints { (make) in
            make.centerY.equalTo((delButton.superview?.snp.centerY)!).offset(0)
            make.left.equalTo(self.swipeContentView.snp.right).offset(0)
            make.width.height.equalTo(50)
        }
        
        bankName.snp.makeConstraints { (make) in
            make.top.equalTo(14)
            make.left.equalTo(24)
            make.height.equalTo(18)
        }
        userName.snp.makeConstraints { (make) in
            make.top.equalTo(self.bankName.snp.bottom).offset(4)
            make.left.equalTo(24)
            make.height.equalTo(14)
        }
        bankNumber.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.bottom.equalTo(-18)
        }
        rightMsg.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-24)
        }
    }
  
    @objc func buttonDidAction()
    {
        print("删除")
        resetFrame()
        guard let _delegate = delegate else {
            return
        }
      
        _delegate.swipeCellDelButtonAction(self)
    }
 

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
