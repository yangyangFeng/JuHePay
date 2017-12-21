//
//  APSelectMerchantCell.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSelectMerchantCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14.0)
        view.theme_textColor = ["#484848"]
        view.textAlignment = .left
        return view
    }()
    
    lazy var arronImageView: UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        view.contentMode = .scaleAspectFit
        view.theme_image = ["wallet_arron_right_icon"]
        return view
    }()
    
    //MARK: ---- 生命周期
    
    static func cellWithTableView(_ tableView: UITableView) -> UITableViewCell? {
        let identifier = "APSelectMerchantCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        guard let newCell = cell else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            
            return cell
        }
        return newCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(arronImageView)
        
        arronImageView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp.right).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(arronImageView.snp.left)
            make.centerY.equalTo(arronImageView.snp.centerY)
        }
    }
    
    func mccModel(mccModel: APMCCModel, selectMccModel: APMCCModel) {
        titleLabel.text = mccModel.mccName
        if selectMccModel.mccId == mccModel.mccId {
            arronImageView.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
