//
//  APNetworkExtension.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/27.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import Foundation

class APHttpUrl {
    
    #if DEBUG
    static let trans_httpUrl: String = "http://172.16.0.101:47700" //交易前置
    static let manange_httpUrl: String = "http://172.16.0.101:47800"  //进件前置
    
    #elseif TEST
    static let trans_httpUrl: String = "http://192.168.2.72:47700" //交易前置
    static let manange_httpUrl: String = "http://192.168.2.72:47800"  //进件前置
    #endif
 
}


class APHttpService {
    
    static let login: String              = "/user/login" //登录
    static let logout: String             = "/user/logout" //退出登录
    static let register: String           = "/user/register" //注册
    static let getUserAccountInfo: String = "/user/getUserAccountInfo"  //钱包余额查询接口(进件前置)
    static let resetPassword: String      = "/user/resetPassword" //忘记密码
    static let updatePassword: String     = "/user/updatePassword" //重置密码
    static let queryAccountRecord: String = "/query/queryAccountRecord"  //钱包明细
    static let sendMessage: String        = "/manager/sendMessage" //获取验证码 (注册、修改密码）
    static let checkMessage: String       = "/manager/checkMessage" //校验短信验证码接口(进件前置)

    /// 身份认证
    static let userAuthInfo: String       = "/user/getUserAuthInfo" // 用户认证信息
    //
    static let realNameAuth: String       = "/user/userRealNameAuth" //实名认证(进件前置)
    static let realNameAuthInfo: String   = "/user/getUserRealNameAuthInfo" //实名认证回显(进件前置)
    static let securityAuth: String       = "/user/userSecurityAuth" //安全认证(进件前置)
    static let securityAuthInfo: String       = "/user/getUserSecurityAuthInfo" //安全认证回显(进件前置)
    static let settleCardAuth: String     = "/user/userAccountAuth" //结算卡认证(进件前置)
    static let settleCardAuthInfo: String     = "/user/getUserAccountAuthInfo" //结算卡认证回显(进件前置)
    
    /// 根据银行名称查询银行列表
    static let searchBank: String = "/user/queryCnapsListByBankName"
    
    //银联快捷收款
    static let queryChannelFees: String        = "/pay/queryChannelFees" //查询银联快捷通道费率
    static let queryQuickPayCardList: String   = "/pay/queryQuickPayCardList" //获取绑定成功的银联快捷卡列表
    static let queryQuickPayResult: String     = "/pay/queryQuickPayResult" //查询银联快捷交易结果
    static let quickPay: String                = "/pay/quickPay" //银联快捷支付
    static let registQuickPay: String          = "/pay/registQuickPay" //银联快捷开通验证码（未开通时候）
    static let registerMsg: String             = "/pay/registerMsg" //银联快捷开通验证码（开通过时候）
    static let transMsg: String             = "/pay/transMsg" //银联快捷开通验证码（交易）
    
    
    
    
    
    static let getMyAccount: String        = "/query/getMyAccount" //获取账单交易查询列表
    static let getMyAccountDetails: String = "/query/getMyAccountDetails" //交易详情
    static let merchantCategory: String   = "/pay/merchantCategory" //获取商户大类
    static let getOnlineTransResult: String   = "/pay/getOnlineTransResult" //获取微信支付宝交易结果
    static let aliPay: String   = "/pay/aliPay" //支付宝生成二维码
    static let wechatPay: String   = "/pay/wechatPay" //微信生成二维码
    
    // 图片下载
    static let downloadImg: String = "/downLoad/downloadImg"

}



