//
//  APLocationTools.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
import CoreLocation

typealias APLocationSuccess = (_ lat: String,_ lng: String) -> Void
typealias APLocationFailed = (_ error: Error) -> Void

extension APLocationTools {
    
    static func location(success: @escaping APLocationSuccess, failure: @escaping APLocationFailed) {
        sharedInstance.successCallBack = success
        sharedInstance.failedCallBack = failure
    }
    
    static func start() {
        sharedInstance.manager?.startUpdatingLocation()
    }
    
    static func stop() {
        sharedInstance.manager?.stopUpdatingLocation()
    }
}

class APLocationTools: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance: APLocationTools = APLocationTools()
    
    var manager: CLLocationManager?
    var successCallBack: APLocationSuccess?
    var failedCallBack: APLocationFailed?
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestAlwaysAuthorization()
        manager?.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for loc: CLLocation in locations {
            let lc2d = loc.coordinate
            let lat: String = String(lc2d.latitude)
            let lnt: String = String(lc2d.longitude)
            successCallBack?(lat, lnt)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        failedCallBack?(error)
    }
    

}
