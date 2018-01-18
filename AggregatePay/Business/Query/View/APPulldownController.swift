//
//  APPulldownController.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/29.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APPulldownController: UIView {
    
    let LEFT_PULLBOX_ID = "LEFT_PULLBOX_ID"
    
    let RIGHT_PULLBOX_ID = "RIGHT_PULLBOX_ID"
    
    weak var m_targetVC: UIViewController?

    init(targetVC: UIViewController) {
        super.init(frame: CGRect.zero)
        m_targetVC = targetVC
        m_targetVC?.view.addSubview(boxView)
        initCreateSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom)
            make.left.right.bottom.equalTo((m_targetVC?.view)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ---- Lazy Loading
    
    lazy var bg_imageView : UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var bottom_line : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var leftPulldownView: APPulldownView = {
        let view = APPulldownView()
        view.title_text = "收款方式:"
        view.button_text = "全部"
        view.addTarget(self, action: #selector(leftPulldownAction))
        return view
    }()
    
    lazy var rightPulldownView: APPulldownView = {
        let view = APPulldownView()
        view.title_text = "结算方式:"
        view.button_text = "D+0"
        view.addTarget(self, action: #selector(rightPulldownAction))
        return view
    }()
    
    lazy var boxView: APPulldownBoxView = {
        let view = APPulldownBoxView()
        view.delegate = self
        return view
    }()
}


//MARK: =================== APPulldownController - Extension(代理方法)

extension APPulldownController: APPulldownBoxViewDelegate {
    
    func ap_selectPulldownBoxViewValue(value: Any, identify: String) {
        
        let selectTitle: String = value as! String
        if identify == LEFT_PULLBOX_ID {
            leftPulldownView.button_text = selectTitle
        }
        else if identify == RIGHT_PULLBOX_ID  {
            rightPulldownView.button_text = selectTitle
        }
    }
}

//MARK: =================== APPulldownController - Extension(按钮触发方法)

extension APPulldownController {
    
    @objc func leftPulldownAction() {
        boxView.showAnimation(identifier: LEFT_PULLBOX_ID)
        boxView.realodData(newDatas: ["全部","银联快捷收款", "微信收款","支付宝收款"])
    }
    
    @objc func rightPulldownAction() {
        boxView.showAnimation(identifier: RIGHT_PULLBOX_ID)
        boxView.realodData(newDatas: ["D+0"])
    }
}

//MARK: =================== APPulldownController - Extension(控件初始化方法)

extension APPulldownController {
    
    private func initCreateSubviews() {
        
        addSubview(bg_imageView)
        addSubview(bottom_line)
        addSubview(leftPulldownView)
        addSubview(rightPulldownView)
        
        bg_imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        bottom_line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-1)
            make.height.equalTo(1)
        }
        leftPulldownView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.bottom.equalTo(0)
            make.right.equalTo(self.snp.centerX)
        }
        
        rightPulldownView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(15)
            make.top.bottom.equalTo(0)
            make.right.equalTo(0)
        }
    }
}

//MARK: =================== APPulldownView - Class

class APPulldownView: UIView {
    
    //MARK: ---- Public
    public var title_text: String? {
        willSet {
            title.text = newValue
        }
    }
    
    public var button_text: String? {
        willSet {
            pulldownButton.text = newValue
        }
    }

    public func addTarget(_ target: Any?, action: Selector) {
        pulldownButton.button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    //MARK: ----- Life Cycle
    init() {
        super.init(frame: CGRect.zero)
        initCreateSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ----- Private
    private func initCreateSubviews() {
        addSubview(title)
        addSubview(pulldownButton)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.bottom.equalTo(0)
            make.centerY.equalTo(snp.centerY)
        }
        pulldownButton.snp.makeConstraints { (make) in
            make.left.equalTo(title.snp.right).offset(5)
            make.right.equalTo(0)
            make.centerY.equalTo(title.snp.centerY)
            make.height.equalTo(self.snp.height).multipliedBy(0.6)
        }
    }
    
    //MARK: ----- Lazy Loading
    let title : UILabel = {
        let view = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 20))
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["#4c370b"]
        view.textAlignment = .left
        return view
    }()
    
    lazy var pulldownButton: APPulldownButton = {
        let view = APPulldownButton()
        return view
    }()
}

//MARK: =================== APPulldownButton - Class

class APPulldownButton: UIView {
    
    //MARK: ----- public
    public var text : String? {
        willSet{
            title.text = newValue
        }
    }
    
    //MARK: ----- Life Cycle
    init() {
        super.init(frame: CGRect.zero)
        initCreateSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ----- Private
    private func initCreateSubviews() {
        
        addSubview(title)
        addSubview(arrow)
        addSubview(button)
        
        title.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(30)
            make.right.lessThanOrEqualToSuperview().offset(-10)
            make.top.bottom.left.equalTo(0)
        }
        arrow.snp.makeConstraints { (make) in
            make.left.equalTo(title.snp.right)
            make.top.bottom.equalTo(title)
            make.width.equalTo(7)
        }
        button.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
   
    //MARK: ----- Lazy Loading
    
    lazy var title: UILabel = {
        let view = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 20))
        view.font = UIFont.systemFont(ofSize: 12)
        view.backgroundColor = UIColor.white
        view.theme_textColor = ["#4c370b"]
        view.textAlignment = .left
        return view
    }()
    
    lazy var arrow: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Bill_Arrow_Default")
        view.backgroundColor = UIColor.white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        return view
    }()
}

//MARK: =================== APPulldownBoxViewDelegate - Protocol

@objc protocol APPulldownBoxViewDelegate : NSObjectProtocol {
    @objc optional func ap_selectPulldownBoxViewValue(value: Any, identify: String)
}


//MARK: =================== APPulldownBoxView - Class

class APPulldownBoxView: UIView {
    
    var identify: String?
    
    var collectionView: UICollectionView?
    
    var delegate: APPulldownBoxViewDelegate?
    
    var datas = [String]()
    
    //MARK: ----- Public
    public func realodData(newDatas: [String]) {
        datas.removeAll()
        datas = newDatas
        collectionView?.layoutIfNeeded()
        collectionView?.reloadData()
    }
    
    //MARK: ----- Life Cycle
    init() {
        super.init(frame: CGRect.zero)
        layer.masksToBounds = true
        backgroundColor = UIColor.init(hex6: 0x000000, alpha: 0.5)
        collectionView = initCollectionView()
        addSubview(collectionView!)
        collectionView?.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(44)
        }
        dissAnimation(animation: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showAnimation(identifier: String) {
        identify = identifier
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 1
        }, completion: {(isCompletion) in
            UIView.animate(withDuration: 0.25, animations: {
                self.collectionView?.transform = CGAffineTransform.init(translationX: 0, y: 0)
            })
        })
    }
    
    public func dissAnimation(animation: Bool) {
        identify = ""
        alpha = 1
        isHidden = false
        
        if !animation {
            self.alpha = 0
            self.isHidden = true
            self.collectionView?.transform = CGAffineTransform.init(translationX: 0, y: -30)
            return
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.collectionView?.transform = CGAffineTransform.init(translationX: 0, y: -30)
        }, completion: {(isCompletion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 0
            }, completion: {(isCompletion) in
                self.isHidden = true
            })
        })
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dissAnimation(animation: true)
    }
}

//MARK: =================== APPulldownBoxView - Extension(初始化方法)

extension APPulldownBoxView {
    
    private func Cell_ID() -> String {
        return "UICollectionViewCell_ID"
    }
    
    private func initCollectionView() -> UICollectionView {
        let layout: UICollectionViewFlowLayout = initCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(APPulldownBoxCell.self, forCellWithReuseIdentifier: Cell_ID())
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }
    
    private func initCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
}

//MARK: =================== APPulldownBoxView - Extension(代理方法)

extension APPulldownBoxView:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = APPulldownBoxCell.cellWithColletionView(collectionView,
                                                           identifier: Cell_ID(),
                                                           indexPath: indexPath)
        cell.textLabel.text = datas[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = (Int(K_Width)/datas.count)
        return CGSize(width: width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let value = datas[indexPath.row]
        delegate?.ap_selectPulldownBoxViewValue!(value: value, identify: identify!)
        dissAnimation(animation: true)
    }
}

//MARK: =================== APPulldownBoxCell - Class

class APPulldownBoxCell: UICollectionViewCell {
    
    static func cellWithColletionView(_ collectionView: UICollectionView,
                                      identifier: String,
                                      indexPath: IndexPath) -> APPulldownBoxCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! APPulldownBoxCell
        return cell
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.theme_textColor = ["0x4c370b"]
        view.textAlignment = .center
        return view
    }()
    
}
















