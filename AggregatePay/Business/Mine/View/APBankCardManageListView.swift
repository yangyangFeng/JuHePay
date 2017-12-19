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
        view.AP_setupEmpty()
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
    var segmentView : APSegmentControl!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        
        segmentView = APSegmentControl.init(["信用卡管理","结算卡管理"], frame: CGRect.init(x: 0, y: 0, width: K_Width, height: 40))
        segmentView.segmentBlock =  { index in
            if index == 0 {
                self.rows = 5
                self.tableView.beginUpdates()
                self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.left)
                self.tableView.endUpdates()
            }
            else
            {
                self.rows = 0
                self.tableView.beginUpdates()
                self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.right)
                self.tableView.endUpdates()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        segmentView.layoutIfNeeded()
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
