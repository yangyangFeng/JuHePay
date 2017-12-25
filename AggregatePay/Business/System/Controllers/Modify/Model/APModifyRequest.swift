//
//  APModifyRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APModifyRequest: APBaseRequest {
    
    //账号(手机号)
    @objc dynamic var mobile: String = ""
    //旧密码
    @objc dynamic var oldPassword: String = ""
    //新密码
    @objc dynamic var newPassword: String = ""
    //重复
    @objc dynamic var repeatPassword: String = ""
    
    

}
