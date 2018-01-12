//
//  APNetworkDowdload.swift
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/12.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class APNetworkDowdload: APNetworkUtil {
    
    //图片缓存
    let imageCache = AutoPurgingImageCache.init(
        // 100M
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    public static let sharedInstance: APNetworkDowdload = {
        let networkRequest = APNetworkDowdload()
        networkRequest.ap_careatesessionManager(timeoutIntervalForRequest: 60)
        return networkRequest
    }()
    
    func ap_download(httpUrl: String = APHttpUrl.manange_httpUrl,
                        action: String = APHttpService.downloadImg,
                        fileName: String,
                        method: HTTPMethod = .get,
                        headers: HTTPHeaders? = nil,
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
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        var requestHeader: HTTPHeaders?
        if cookie != "" {
            requestHeader = ["cookie":cookie]
        }
        var request: DataRequest!
        // 缓存中没有图片，从url加载图片
        request = Alamofire.request( to,
                                     method: method,
                                     parameters: params,
                                     headers: requestHeader)
        request.responseImage(completionHandler:{ [weak self] (response) in
            debugPrint(response)
            guard let image = response.result.value else {
                failure(response.result.error!)
                return
            }
            success(image)
            self?.cacheImage(image, for: (to + fileName))
        })
    }
}


extension APNetworkDowdload {
    
    //缓存图片
    public func cacheImage(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    //从缓存中取出图片
    public func imageFromCached(for url: String) -> Image? {
        return imageCache.image(withIdentifier:url)
    }
}


