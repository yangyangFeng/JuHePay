//
//  APFormData.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/29.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APFormData: NSObject {
    private var image: UIImage = UIImage()
    public var name: String = ""
    public var fileName: String = ""
    public var mimeType: String = "image/jpeg"
    public var data: Data = Data.init()
    
    init(image: UIImage, name: String) {
        self.image = image
        self.name = name
        self.fileName = name
        self.data = UIImageJPEGRepresentation(image, 0.1)!
    }
}

