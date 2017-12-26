//
//  APBaseRequest.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit



class APBaseRequest: NSObject {
    
    //版本号
    @objc dynamic var appVersion: String = "ios.ZFT.1.0.0"

    //签名
    @objc dynamic var sign: String = "111"
    
}

//extension APBaseRequest {
//
//    typealias APKeyValueParamsBlock = (_ key: String,_ value: Any) -> Void
//
//    //MARK: ---- pubilc
//    public func keyValue() -> Dictionary<String, Any> {
//        var parameters: Dictionary<String, Any> = [:]
//        let mirror = Mirror(reflecting: self)
//        mirrorParams(mirror: mirror) { (key, value) in
//            parameters[key] = value
//        }
//        return parameters
//    }
//
//
//    //MARK: ---- private
//    private func mirrorParams(mirror: Mirror, paramsBlock: APKeyValueParamsBlock) {
//        for property in (mirror.children) {
//            let name = property.label!
//            let value = property.value
//            print("name:\(name) ---- value:\(value)")
//            paramsBlock(name, value)
//        }
//        let superMirror = mirror.superclassMirror
//        let superClass: String = "\((superMirror?.subjectType)!)"
//        if superClass != "NSObject" {
//
//        }
//        else {
//            mirrorParams(mirror: superMirror!, paramsBlock: paramsBlock)
//        }
//    }
//}

