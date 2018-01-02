//
//  APQRCPHttpTool.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/29.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APQRCPHttpTool: NSObject {

    func getOnlineTransResultRequestTool() {
        let param = String()
        let url = URL.init(string: "url")
        let session = URLSession.shared
        let request = NSMutableURLRequest.init(url: url!)
        let cookie = APUserDefaultCache.AP_get(key: .cookie) as! String
        request.timeoutInterval = 30
        request.httpMethod = "GET"
        request.httpBody = param.data(using: String.Encoding.utf8)
        request.setValue(cookie, forHTTPHeaderField: cookie)
        let dataTask = session.dataTask(with: request as URLRequest)
        { (data, response, error) in
            if (error != nil) {
                print("error")
            }
            else {
                let json: Any = try! JSONSerialization.jsonObject(with: data!, options: [])
                print("json")
            }
        }
        dataTask.resume()
    }
    
}
