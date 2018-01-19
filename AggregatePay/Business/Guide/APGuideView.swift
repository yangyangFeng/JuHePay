//
//  APGuideView.swift
//  AggregatePay
//
//  Created by cnepayzx on 2018/1/4.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

import UIKit

typealias APGuideViewDismissBlock = () -> Void

class APGuideView: UIView,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate {

    static let app_version =  Bundle.main.infoDictionary!["CFBundleShortVersionString"]
    static var userDefault = UserDefaults.standard
    
    static func showGuideView(dismiss: @escaping APGuideViewDismissBlock) {
        if userDefault.object(forKey: app_version as! String) == nil {
            let window = UIApplication.shared.keyWindow
            let guideView : APGuideView = APGuideView.init(frame: (window?.bounds)!,
                                                           title: ["APGuideView0",
                                                                   "APGuideView1",
                                                                   "APGuideView2"])
            guideView.guideViewDismissBlock = dismiss
            window?.addSubview(guideView)
        }
        else
        {
            dismiss()
        }
    }
    
    var guideViewDismissBlock: APGuideViewDismissBlock?
    
    lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal;
        flowlayout.itemSize = self.size
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        let view = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowlayout)
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.register(cellWithClass: APGuideViewCell.self)
        return view
    }()
    
    //分页控制器
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl(frame:CGRect.zero)
        pageControl.pageIndicatorTintColor = UIColor.init(hex6: 0xd8d8d8)
        pageControl.currentPageIndicatorTintColor = UIColor.init(hex6: 0xf4b04b)
        return pageControl
    }()
    
    lazy var skitBtn : UIButton = {
       let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(skitDidAction), for: .touchUpInside)
        view.theme_setBackgroundImage(["APGuideViewSkitBtn"], forState: .normal)
        view.alpha = 0;
        return view
    }()
    
    var images : [String] = []
    
    var isFirst : Bool = true
    
    
    convenience init(frame: CGRect,title:[String]) {
        self.init(frame: frame)
        images = title
        self.pageControl.numberOfPages = images.count
        collectionView.reloadData()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        addMotionEffect(UIMotionEffect)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(skitBtn)
        backgroundColor = .white
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(0)
        }
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(-40)
            make.centerX.equalToSuperview().offset(0)
            make.height.equalTo(6)
            make.width.equalTo(45)
        }
        skitBtn.snp.makeConstraints { (make) in
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.centerX.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: APGuideViewCell.self, for: indexPath)
        cell?.imageView.theme_image = [images[indexPath.row]]
        return cell!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/self.width)
        if(index < Int(images.count)){
            self.pageControl.currentPage = index;
            if (index == (images.count - 1)) {
                UIView.animate(withDuration: 0.25, animations: {
                    self.skitBtn.alpha = 1
                }, completion: { (state) in
                    if self.isFirst{
                        self.skitBtn.shake()
                        self.isFirst = false
                    }
                })
            }
            else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.skitBtn.alpha = 0
                })
            }
        }else{
//            self.perform(#selector(self.skipBtnClicK), with: nil, afterDelay: 0)
          
            
        }
        let count : CGFloat = CGFloat(images.count - 1)
        
        if(scrollView.contentOffset.x > scrollView.contentSize.width - width * count){
            let distance = scrollView.contentOffset.x - width * count;
            backgroundColor = UIColor.init(white: 1, alpha: 1-(distance/width))
            if ((distance/width) > 0.2){
                dismiss()
            }
        }
    }

    @objc func skitDidAction(){
        dismiss()
    }
    
    func dismiss(){
        APGuideView.userDefault.set(false, forKey: APGuideView.app_version as! String)
        UIView.animate(withDuration: 0.15, animations: {
            self.pageControl.alpha = 0
            self.skitBtn.snp.updateConstraints { (make) in
                make.bottom.equalToSuperview().offset(self.skitBtn.height)
            }
            self.collectionView.snp.updateConstraints { (make) in
                make.left.equalTo(-self.width*3)
            }
            self.layoutIfNeeded()
            self.backgroundColor = UIColor.init(white: 1, alpha: 0)
        }) { (state) in
            self.removeSubviews()
            self.removeFromSuperview()
            self.guideViewDismissBlock?()
        }
    }
}

class APGuideViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
