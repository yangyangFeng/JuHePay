//
//  CPNetworking.swift
//  framework
//
//  Created by BlackAnt on 2017/12/4.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

typealias APNetWorkingSuccessBlock = (_ result: APBaseResponse) -> Void
typealias APNetWorkingFaileBlock = (_ error: APBaseError) -> Void

/**
 * 网络工具类(常用)
 * 二次封装Alamofire
 * 基本功能:
 *       post请求:
 */
class APNetworking: NSObject {
    
    var manager: SessionManager!
    
    var dataRequest:DataRequest?
    
    static let sharedInstance = APNetworking()
    
    ///图片缓存
    let imageCache = AutoPurgingImageCache.init(
        // 100M
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    
    static func get(httpUrl: String = APHttpUrl.trans_httpUrl,
                    action: String,
                    params: APBaseRequest,
                    aClass: Swift.AnyClass,
                    success: @escaping APNetWorkingSuccessBlock,
                    failure faile: APNetWorkingFaileBlock? = nil) {
        
        sharedInstance.packagingRequest(httpUrl: httpUrl,
                                        action: action,
                                        method: .get,
                                        params: params,
                                        aClass: aClass,
                                        success: success,
                                        failure: faile)
    }
    
    /**
     * post网络请求
     */
    static func post(httpUrl: String = APHttpUrl.trans_httpUrl,
                     action: String,
                     params: APBaseRequest,
                     aClass: Swift.AnyClass,
                     success:@escaping APNetWorkingSuccessBlock,
                     failure faile: APNetWorkingFaileBlock? = nil) {
        
        sharedInstance.packagingRequest(httpUrl: httpUrl,
                                        action: action,
                                        method: .post,
                                        params: params,
                                        aClass: aClass,
                                        success: success,
                                        failure: faile)
    }
    
    /// 图片上传
    ///
    /// - Parameters:
    ///   - httpUrl: host URL
    ///   - action: 接口
    ///   - params: 参数
    ///   - formDatas: 图片数据
    ///   - aClass: 响应model
    ///   - success: 成功回调
    ///   - failure: 失败回调
    
    static func upload(
        httpUrl: String = APHttpUrl.manange_httpUrl,
        action: String,
        params: APBaseRequest,
        formDatas: [APFormData],
        aClass: Swift.AnyClass,
        success: @escaping APNetWorkingSuccessBlock,
        failure: APNetWorkingFaileBlock? = nil)
    {
        let sharedInstance = APNetworking()
        sharedInstance.packagingUpload(
            httpUrl: httpUrl,
            action: action,
            method: .post,
            params: params,
            formDatas: formDatas,
            aClass: aClass,
            success: success,
            failure: failure)
        
    }
    
    /// 图片下载
    static func download(
        httpUrl: String = APHttpUrl.manange_httpUrl,
        action: String = APHttpService.downloadImg,
        fileName: String,
        params: APBaseRequest,
        success: @escaping (UIImage) -> Void,
        failure: APNetWorkingFaileBlock? = nil)
    {
        let sharedInstance = APNetworking()
        sharedInstance.packagingDownload(
            httpUrl: httpUrl,
            action: action,
            fileName: fileName,
            method: .get,
            params: params,
            success: success,
            failure: failure)
    }
    
    
    /**
     * 取消当前网络请求
     */
    static public func cancelCurrentRequest() {
        sharedInstance.dataRequest?.cancel()
    }
}

//extension

//MARK: ---- 扩展

extension APNetworking {

    func packagingRequest(httpUrl: String = APHttpUrl.trans_httpUrl,
                          action: String,
                          method: HTTPMethod = .post,
                          params: APBaseRequest,
                          aClass: Swift.AnyClass,
                          success:@escaping APNetWorkingSuccessBlock,
                          failure faile: APNetWorkingFaileBlock? = nil)
    {
        params.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        let parameters = params.mj_keyValues() as! Dictionary<String, Any>
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        var requestHeader: HTTPHeaders?
        if cookie != "" {
            requestHeader = ["cookie":cookie]
        }
        request(httpUrl: httpUrl,
                action: action,
                method: method,
                headers: requestHeader,
                parameters: parameters,
                success:{ (result) in
                    let baseResp = APClassRuntimeTool.ap_class(aClass, result: result) as! APBaseResponse
                    print("respMsg"+baseResp.respMsg!)
                    if baseResp.success == "0" || baseResp.isSuccess == "0" {
                        let baseError = APBaseError()
                        if baseResp.respCode != nil {
                            baseError.status = baseResp.respCode
                        } else {
                            baseError.status = "0"
                        }
                        baseError.message = baseResp.respMsg
                        if !self.checkoutNeedLogin(status: baseError.status!) {
                            faile?(baseError)
                        }
                    }
                    else {
                        success(baseResp)
                    }
        }) { (error) in
            let baseError = APBaseError()
            baseError.status = error.localizedDescription
            baseError.message = error.localizedDescription
            faile?(baseError)
        }
    }
    
    func packagingUpload(httpUrl: String = APHttpUrl.manange_httpUrl,
                          action: String,
                          method: HTTPMethod = .post,
                          params: APBaseRequest,
                          formDatas: [APFormData],
                          aClass: Swift.AnyClass,
                          success:@escaping APNetWorkingSuccessBlock,
                          failure faile: APNetWorkingFaileBlock? = nil)
    {
        params.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        let parameters = params.mj_keyValues() as! Dictionary<String, Any>
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        var requestHeader: HTTPHeaders?
        if cookie != "" {
            requestHeader = ["cookie":cookie]
        }
        
        uploadFormDatas(
            action: action,
            headers: requestHeader,
            parameters: parameters,
            formDatas: formDatas,
            success: { (result) in
                let baseResp = APClassRuntimeTool.ap_class(aClass, result: result) as! APBaseResponse
                if baseResp.success == nil && baseResp.isSuccess == nil {
                    faile?(self.error(result: result))
                }
                else if baseResp.success == "0" || baseResp.isSuccess == "0" {
                    let baseError = APBaseError()
                    baseError.status = baseResp.respCode
                    baseError.message = baseResp.respMsg
                    //是否登录超时
                    if !self.checkoutNeedLogin(status: baseError.status!) {
                        faile?(baseError)
                    }
                }
                else {
                    success(baseResp)
                }
                
        }) { (error) in
            let baseError = APBaseError()
            baseError.status = error.localizedDescription
            baseError.message = error.localizedDescription
            faile?(baseError)
        }
    }
    
    /**
     * 网络请求
     * @param   action:请求接口(APCommon.Port)
     * @param   method:请求方式
     * @param   parameters:请求参数
     * @param   success:请求成功回调
     * @param   faile:请求失败回调
     *
     */
    func request(httpUrl: String = APHttpUrl.trans_httpUrl,
                 action: String,
                 method: HTTPMethod = .get,
                 headers: HTTPHeaders? = nil,
                 timeOut: TimeInterval = 30,
                 parameters:Dictionary<String, Any>,
                 success:@escaping (Dictionary<String, Any>)->Void,
                 faile:@escaping (Error)->Void) {
        
        let httpUrl = httpUrl+action
        print("===============star===============")
        print("method:"+method.rawValue)
        print("url:"+httpUrl)
        print("param:"+String(describing: parameters))
   
        manager = ap_alamofireManager(timeOut)
        dataRequest = manager.request(httpUrl,
                                      method:method,
                                      parameters: parameters,
                                      headers: headers).responseJSON { response in
                            switch response.result.isSuccess {
                            case true:
                                
                                print("response-value:\(String(describing: response.value))")
                                self.cacheCookie(response: response)
                                let result = response.value! as! Dictionary<String, Any>
                                if !result.keys.contains("isSuccess") &&
                                   !result.keys.contains("success") {
                                    let baseError = self.error(result: result)
                                    faile(baseError)
                                }
                                else {
                                    success(result)
                                }
                                print("===============end================")
                            case false:
                                print("response:\(String(describing: response.result.error?.localizedDescription))")
                                faile(response.result.error!)
                                print("===============end================")
                            }
        }
    }
    
    func checkoutNeedLogin(status: String) -> Bool {
        if status == "NEED_LOGIN" {
            NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "NEED_LOGIN"), object: nil, userInfo: nil))
            return true
        }
        return false
    }
    
    func error(result: Dictionary<String, Any>) -> APBaseError {
        let baseError = APClassRuntimeTool.ap_class(APBaseError.self, result: result) as! APBaseError
        if baseError.status == "404" {
            baseError.message = "请求服务器失败"
        }
        else {
            baseError.message = "请求服务器失败"
        }
        return baseError
    }
    
    
    /// 图片上传
    ///
    /// - Parameters:
    ///   - httpUrl: httpUrl
    ///   - httpUrl: httpUrl
    ///   - httpUrl: httpUrl
    ///   - httpUrl: httpUrl
    ///   - httpUrl: httpUrl
    ///   - parameters: parameters
    ///   - formDatas: formDatas
    ///   - success: success
    ///   - failure: failure
    
    func uploadFormDatas(httpUrl: String = APHttpUrl.manange_httpUrl,
                action: String,
                method: HTTPMethod = .post,
                headers: HTTPHeaders? = nil,
                timeout: TimeInterval = 90,
                parameters: Dictionary<String, Any>,
                formDatas: [APFormData],
                success: @escaping (Dictionary<String, Any>)->Void,
                failure: @escaping (Error)->Void)
    {
        print("===============star===============")
        let to = httpUrl + action
        print("method:"+method.rawValue)
        print("url:"+to)
        print("param:"+String(describing: parameters))
        
        manager = ap_alamofireManager(timeout)
        
        manager.upload(multipartFormData: {
            (multipartFormData) in
            
            for formData in formDatas {
                multipartFormData.append(formData.data,
                                         withName: formData.name,
                                         fileName: formData.fileName,
                                         mimeType: formData.mimeType)
            }
            for (key, value) in parameters {
                multipartFormData.append(String(describing: value).data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold: UInt64.init(),
           to: to,
           method: method,
           headers: headers,
           encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result.isSuccess {
                    case true:
                        self.cacheCookie(response: response)
                        print("response-value:\(String(describing: response.value))")
                        success(response.value! as! Dictionary<String, Any>)
                        print("===============end================")
                    case false:
                        print("response:\(String(describing: response.result.error?.localizedDescription))")
                        failure(response.result.error!)
                        print("===============end================")
                    }
                })
            case .failure(let error):
                print("response:\(String(describing: error.localizedDescription))")
                failure(error)
                print("===============end================")
            }
        })
    }
    
//    func downloadImage(
//        httpUrl: String = APHttpUrl.manange_httpUrl,
//        action: String = APHttpService.downloadImg,
//        fileName: String,
//        method: HTTPMethod = .get,
//        headers: HTTPHeaders? = nil,
//        timeout: TimeInterval = 30,
//        params: Dictionary<String, Any>,
//        success: @escaping (UIImage)->Void,
//        failure: @escaping (Error)->Void)
//    {
//        print("===============star===============")
//        let to = httpUrl + action
//        print("method:"+method.rawValue)
//        print("url:"+to)
//        print("param:"+String(describing: params))
//
//        let config:URLSessionConfiguration = URLSessionConfiguration.default
//        config.timeoutIntervalForRequest = timeout
//        manger = SessionManager(configuration: config)
//
//        manger?.download(
//            to,
//            method: method,
//            parameters: params,
//            encoding: URLEncoding.default,
//            headers: headers,
//            to:{
//                (_, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
//
//                let subPath = "auth/" + fileName + ".png"
//                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                let fileURL = documentsURL.appendingPathComponent(subPath)
//                //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
//                debugPrint(fileURL)
//                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//
//        }).response(completionHandler: {(response) in
//            debugPrint(response)
//            if response.response?.statusCode == 200 {
//                if let path = response.destinationURL?.path {
//                    success(UIImage.init(contentsOfFile: path)!)
//                }
//            }else {
//                if response.error != nil {
//                    failure(response.error!)
//                } else {
//                    let baseError = APBaseError()
//                    baseError.status = "\(String(describing: response.response?.statusCode))"
//                    baseError.message = "请求错误"
//                    failure(baseError)
//                }
//            }
//        })
//    }
    
    func cacheCookie(response: DataResponse<Any>) {
        let httpUrlResponse = response.response
        let headerFields = httpUrlResponse?.allHeaderFields
        if let cookie = headerFields!["Set-Cookie"] {
            APUserDefaultCache.AP_set(value: cookie as Any, key: .cookie)
        }
    }
    
    func securityPolicy() {
        
        
    }
}

extension APNetworking {
    
    func packagingDownload(httpUrl: String = APHttpUrl.manange_httpUrl,
                           action: String,
                           fileName: String,
                           method: HTTPMethod = .get,
                           params: APBaseRequest,
                           success:@escaping (UIImage) -> Void,
                           failure: APNetWorkingFaileBlock? = nil)
    {
        params.userId = APUserDefaultCache.AP_get(key: .userId) as? String
        let parameters = params.mj_keyValues() as! Dictionary<String, Any>
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        var requestHeader: HTTPHeaders?
        if cookie != "" {
            requestHeader = ["cookie":cookie]
        }
        
        downloadImage(httpUrl: httpUrl,
                      action: action,
                      fileName: fileName,
                      method: .get,
                      headers: requestHeader,
                      params: parameters,
                      success: { (image) in
                        success(image)
        }) { (error) in
            let baseError = APBaseError()
            baseError.status = error.localizedDescription
            baseError.message = error.localizedDescription
            failure?(baseError)
        }
        
    }
    
    func downloadImage(
        httpUrl: String = APHttpUrl.manange_httpUrl,
        action: String = APHttpService.downloadImg,
        fileName: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        timeout: TimeInterval = 60,
        params: Dictionary<String, Any>,
        success: @escaping (UIImage)->Void,
        failure: @escaping (Error)->Void)
    {
        print("===============DownloadImage star===============")
        let to = httpUrl + action
        print("method:"+method.rawValue)
        print("url:"+to)
        print("param:"+String(describing: params))
        
        // 从缓存中取出图片
        if let image = imageFromCached(for: (to + fileName)) {
            success(image)
            return
        }
        
        // 缓存中没有图片，从url加载图片
        Alamofire.request(
            to,
            method: method,
            parameters: params,
            headers: headers).responseImage(completionHandler: { [weak self] (response) in
                
                debugPrint(response)
                
//                switch response.result.isSuccess {
//                case true:
//                    print("response-value:\(String(describing: response.value))")
//                    let result = response.value! as! Dictionary<String, Any>
//                    if !result.keys.contains("isSuccess") &&
//                        !result.keys.contains("success") {
//                        let baseError = self.error(result: result)
//                        failure(baseError)
//                    }
//                    else {
//                        success(result)
//                    }
//                    print("===============end================")
//                case false:
//                    print("response:\(String(describing: response.result.error?.localizedDescription))")
//                    faile(response.result.error!)
//                    print("===============end================")
//                }
                
                guard let image = response.result.value else {
                    failure(response.result.error!)
                    return
                }
                success(image)
                self?.cacheImage(image, for: (to + fileName))
            })
    }
    
}

extension APNetworking {
    
    //TODO:  忽略https http://wangsen.website/posts/46398/
    public func ap_alamofireManager(_ timeoutIntervalForRequest: TimeInterval = 60) -> SessionManager {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutIntervalForRequest
        
        let manager = SessionManager(configuration: configuration)
        
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            return (URLSession.AuthChallengeDisposition.useCredential,
                    URLCredential(trust:challenge.protectionSpace.serverTrust!))
        }
        return manager
    }
}

extension APNetworking {
    
    //缓存图片
    public func cacheImage(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    //从缓存中取出图片
    public func imageFromCached(for url: String) -> Image? {
        return imageCache.image(withIdentifier:url)
    }
    
}

extension UInt64 {
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
}









