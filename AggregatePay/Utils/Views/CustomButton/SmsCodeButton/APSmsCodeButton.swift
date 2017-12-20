//
//  APSmsCodeButton.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APSmsCodeButton: UIButton {
    
    deinit {
        print("APSmsCodeButton ------- 已释放")
    }
    
    var countDownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            self.setTitle("\(newValue)秒后重发", for: .normal)
            if newValue <= 0 {
                self.setTitle("重新获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countDownTimer = Timer.scheduledTimer(timeInterval: 1,
                                                      target: self,
                                                      selector: #selector(updateTime(_:)),
                                                      userInfo: nil,
                                                      repeats: true)
                RunLoop.main.add(countDownTimer!, forMode:RunLoopMode.commonModes)
                remainingSeconds = 60
            }
            else {
                countDownTimer?.invalidate()
                countDownTimer = nil
            }
            self.isEnabled = !newValue
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateTime(_ timer: Timer) {
        print(".......")
        remainingSeconds -= 1
    }
}
