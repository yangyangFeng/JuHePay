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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return APPhotoGridViewCell()
    }

}

extension APRealNameAuthViewController {
    func layoutViews() {
        let idCardFrontView = APPhotoGridViewCell()
        let idCardBackView = APPhotoGridViewCell()
        let holdIdCardView = APPhotoGridViewCell()
        let exampleView = APPhotoGridViewCell()
        
    }
}
