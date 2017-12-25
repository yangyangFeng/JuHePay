//
//  APGridViewModel.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/14.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

enum GridState {
    case normal, canPreview, failure, other
}

typealias APGridViewTapedHandle = () -> Void
class APGridViewModel: NSObject {
    var headMessage: String?
    var bottomMessage: String?
    var placeHolderImageName: String?
    var image: UIImage?
    var gridState: GridState = .normal
    var tapedHandle: APGridViewTapedHandle?
    
}
