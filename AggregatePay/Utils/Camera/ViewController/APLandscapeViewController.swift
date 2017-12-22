//
//  APLandscapeNavigationViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/20.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APLandscapeViewController: APBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APPDElEGATE.isLandscape = true
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APPDElEGATE.isLandscape = false
        
        let unknownValue = UIInterfaceOrientation.unknown.rawValue
        UIDevice.current.setValue(unknownValue, forKey: "orientation")
        
        let orientationTarget = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientationTarget, forKey: "orientation")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
}
