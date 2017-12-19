//
//  APGridViewModel.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum GridState {
    case normal, uploaded, downLoaded, failure, other
}
class APGridViewModel: NSObject {
    var headMessage: String?
    var bottomMessage: String?
    var imageName: String?
    var gridState: GridState = .normal

}
