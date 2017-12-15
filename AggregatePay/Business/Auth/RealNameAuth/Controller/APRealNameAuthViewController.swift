//
//  APRealNameAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRealNameAuthViewController: APAuthBaseViewController {
    
    override func viewDidLoad() {
        gridCount = 4
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension APRealNameAuthViewController {
    func layoutViews() {
//        let idCardFrontView = APPhotoGridViewCell()
//        let idCardBackView = APPhotoGridViewCell()
//        let holdIdCardView = APPhotoGridViewCell()
//        let exampleView = APPhotoGridViewCell()
        
    }
}

extension APRealNameAuthViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return APPhotoGridViewCell()
    }
    
    
}
