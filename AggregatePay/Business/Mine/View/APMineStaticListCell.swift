//
//  APMineStaticListCell.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/12.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

let Service_tel = "400-666-888"

class APMineStaticListCell: UITableViewCell {

    public let leftIcon = UIImageView()
    public let title = UILabel()
    public let arrow = UIImageView()
    public let telButton = UIButton(type: UIButtonType.custom)
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APMineStaticListCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        guard let newCell = cell else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            return cell
        }
        return newCell
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let bottomLine = UIView()
        bottomLine.theme_backgroundColor = ["#e8e8e8"]
        
        title.font = UIFont.systemFont(ofSize: 14)
        title.theme_textColor = ["#484848"]
        title.textAlignment = .left
        title.text = "我的钱包"
        
        telButton.theme_setTitleColor(["#999999"], forState: UIControlState.normal)
        telButton.setTitle(Service_tel, for: UIControlState.normal)
        telButton.titleLabel?.textAlignment = .right
        
        telButton.addTarget(self, action: #selector(telButtonAction), for: UIControlEvents.touchUpInside)
        
        arrow.theme_image = ["Mine_head_arrow"]
        
        contentView.addSubview(title)
        contentView.addSubview(telButton)
        contentView.addSubview(leftIcon)
        contentView.addSubview(arrow)
        contentView.addSubview(bottomLine)
        
        leftIcon.snp.makeConstraints { (make) in
            make.height.width.equalTo(20)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.left.equalTo(22)
        }
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftIcon.snp.centerY).offset(0)
            make.left.equalTo(leftIcon.snp.right).offset(10)
        }
        arrow.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
            make.right.equalTo(-19)
        }
        telButton.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.centerY.equalTo(contentView.snp.centerY).offset(0)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.height.equalTo(2.5)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }
    
    @objc func telButtonAction()
    {
        let alertC = UIAlertController(title: "提示", message: ("是否要拨打" + (telButton.titleLabel?.text)!), defaultActionButtonTitle: "取消", tintColor: UIColor.black)
        
        alertC.addAction(UIAlertAction.init(title: "拨打", style: UIAlertActionStyle.cancel, handler: { (alert) in
            
            let phoneUrl : NSURL = NSURL(string: "tel:" + (self.telButton.titleLabel?.text)!)!
            UIApplication.shared.openURL(phoneUrl as URL)
        }))
        alertC.show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
