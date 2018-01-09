//
//  APSmsCodeButton.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/19.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum APCountingStatus: Int {
    case wait    = 1
    case start   = 2
    case end     = 3
}

class APSmsCodeButton: UIButton {
    
    deinit {
        print("APSmsCodeButton ------- 已释放")
    }
    
    var countDownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            self.setTitle("\(newValue)秒后重发", for: .normal)
            if newValue <= 0 {
                countingStatus = .end
            }
        }
    }
    
    var oldCountingStatus: APCountingStatus = .end
    
    var countingStatus: APCountingStatus = .end {
        willSet {
            if newValue == .wait {
                countDownTimer?.invalidate()
                countDownTimer = nil
                self.setTitle("正在发送", for: .normal)
                self.isEnabled = false
                oldCountingStatus = newValue
            }
            else if newValue == .start {
                if oldCountingStatus != .wait {
                    print("开始倒计时之前状态必须处于wait")
                    return
                }
                countDownTimer = Timer.scheduledTimer(timeInterval: 1,
                                                      target: self,
                                                      selector: #selector(updateTime(_:)),
                                                      userInfo: nil,
                                                      repeats: true)
                RunLoop.main.add(countDownTimer!, forMode:RunLoopMode.commonModes)
                remainingSeconds = 60
                isEnabled = false
                oldCountingStatus = newValue
            }
            else {
                countDownTimer?.invalidate()
                countDownTimer = nil
                self.setTitle("重新获取验证码", for: .normal)
                self.isEnabled = true
                oldCountingStatus = newValue
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateTime(_ timer: Timer) {
        print("....updateTime...")
        remainingSeconds -= 1
    }
}
