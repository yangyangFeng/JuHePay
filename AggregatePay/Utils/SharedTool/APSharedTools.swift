//
//  APSharedTools.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APSharedParamBlock = (_ param: APSharedParam) -> Void
typealias APSharedFailedBlock = (_ error: String) -> Void
typealias APSharedSuccessBlock = () -> Void


extension APSharedTools {
    
    static func shared(param: @escaping APSharedParamBlock,
                       failure: @escaping APSharedFailedBlock,
                       success: @escaping APSharedSuccessBlock) {

        sharedInstance.failedCallBack = failure
        sharedInstance.successCallBack = success
        let sharedParam = APSharedParam()
        param(sharedParam)
        sharedInstance.sendShared(param: sharedParam)
    }
}


class APSharedTools: NSObject, WXApiDelegate {
    
   
    static let sharedInstance: APSharedTools = APSharedTools()
    
    var successCallBack: APSharedSuccessBlock?
    var failedCallBack: APSharedFailedBlock?
    
    let message: WXMediaMessage = WXMediaMessage()
    let imageObject: WXImageObject = WXImageObject()
    let sendManager: SendMessageToWXReq = SendMessageToWXReq()
    
    func sendShared(param: APSharedParam) {
        
        imageObject.imageData = UIImagePNGRepresentation(param.sharedImage!)
        message.setThumbImage(param.thumbImage)
        message.mediaObject = imageObject
        sendManager.bText = false;
        sendManager.scene = (param.sharedScene?.rawValue)!
        sendManager.message = message;
        WXApi.send(sendManager)
    }

    func register(key: String) {
        WXApi.registerApp("wxe8e1cc1454887984")
    }
    
    func openURl(url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    //MARK: WXApiDelegate
    
    func onResp(_ resp: BaseResp!) {
        
        if resp.errCode ==  WXSuccess.rawValue {
            successCallBack?()
        }
        else if resp.errCode == WXErrCodeCommon.rawValue {
            failedCallBack?("普通错误类型")
        }
        else if resp.errCode == WXErrCodeUserCancel.rawValue {
            failedCallBack?("用户点击取消并返回")
        }
        else if resp.errCode == WXErrCodeSentFail.rawValue {
            failedCallBack?("发送失败")
        }
        else if resp.errCode == WXErrCodeAuthDeny.rawValue {
            failedCallBack?("授权失败")
        }
        else if resp.errCode == WXErrCodeAuthDeny.rawValue {
            failedCallBack?("微信不支持")
        }
        else {
            failedCallBack?("分享失败")
        }
    }
}


class APSharedParam: NSObject {
    
    //用户状态
    enum APSharedScene: Int32 {
        case friend   = 0  /**< 聊天界面    */
        case circle  = 1  /**< 朋友圈      */
    }
    
    var thumbImage: UIImage?
    var sharedImage: UIImage?
    var sharedScene: APSharedScene?
}

