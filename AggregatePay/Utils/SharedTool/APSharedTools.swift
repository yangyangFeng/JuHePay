//
//  APSharedTools.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

typealias APSharedFailedBlock = (_ error: String) -> Void
typealias APSharedSuccessBlock = () -> Void


extension APSharedTools {
    
    
    static func shared(image: UIImage,
                       scene: APSharedScene,
                       success: @escaping APSharedSuccessBlock,
                       failure: @escaping APSharedFailedBlock) {
        sharedInstance.failedCallBack = failure
        sharedInstance.successCallBack = success
        sharedInstance.sendShared(image: image, scene: scene)
    }
}

enum APSharedScene: Int32 {
    case friend   = 0  /**< 聊天界面    */
    case circle  = 1  /**< 朋友圈      */
}

class APSharedTools: NSObject, WXApiDelegate {
    
    
    static let sharedInstance: APSharedTools = APSharedTools()
    
    var successCallBack: APSharedSuccessBlock?
    var failedCallBack: APSharedFailedBlock?
    
    let message: WXMediaMessage = WXMediaMessage()
    let imageObject: WXImageObject = WXImageObject()
    let sendManager: SendMessageToWXReq = SendMessageToWXReq()
    
    func sendShared(image: UIImage, scene: APSharedScene) {
        
        imageObject.imageData = UIImagePNGRepresentation(image)
        message.setThumbImage(image)
        message.mediaObject = imageObject
        sendManager.bText = false;
        sendManager.scene = Int32(scene.rawValue)
        sendManager.message = message;
        WXApi.send(sendManager)
    }

    func register(key: String) {
        WXApi.registerApp(key)
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

