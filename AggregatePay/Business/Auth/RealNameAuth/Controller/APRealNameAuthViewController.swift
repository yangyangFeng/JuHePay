//
//  APRealNameAuthViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APRealNameAuthViewController: APAuthBaseViewController {
    
   private let realNameCell = APRealNameFormCell()
   private let idCardNoCell = APIdCardNoFormCell()
    
   private let idCardFront = APGridViewModel()
   private let idCardResver = APGridViewModel()
   private let holdIdCard = APGridViewModel()
   private let example = APGridViewModel()
    
    lazy var authParam: APRealNameAuthRequest = {
        let authParam = APRealNameAuthRequest()
        return authParam
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "实名认证"

        setUpUI()
        registerCallBacks()
    }
    
    
    /// 组装认证参数、输入回调
    override func registerCallBacks() {
        super.registerCallBacks()
        
        // 真实姓名
        realNameCell.textBlock = { [weak self] (key, value) in
            self?.authParam.realName = value
        }
        
        //身份证号
        idCardNoCell.textBlock = { [weak self] (key, value) in
            self?.authParam.idCard = value
        }
        
        // 点击身份证
        idCardFront.tapedHandle = { [weak self] in
            let cameraVC = APCameraViewController()
            cameraVC.delegate = self
            cameraVC.scanCardType = TIDCARD2
            cameraVC.supportCameraMode = .all
            self?.present(cameraVC, animated: true, completion: nil)
        }
        // 身份证照片
        idCardFront.setImageComplete = { [weak self] (image) in
            self?.authParam.idCardFront = image
        }
        
        // 点击身份证反面
        idCardResver.tapedHandle = { [weak self] in
            let cameraVC = APCameraViewController()
            cameraVC.delegate = self
            cameraVC.supportCameraMode = .takePhoto
            self?.present(cameraVC, animated: true, completion: nil)
        }
        // 身份证反面
        idCardResver.setImageComplete = { [weak self] (image) in
            self?.authParam.idCardBack = image
        }
        
        // 点击手持身份证
        holdIdCard.tapedHandle = {[weak self] in
            let cameraVC = APCameraViewController()
            cameraVC.delegate = self
            cameraVC.supportCameraMode = .takePhoto
            self?.present(cameraVC, animated: true, completion: nil)
        }
        // 手持身份证照片
        holdIdCard.setImageComplete = { [weak self] (image) in
            self?.authParam.handIdCard = image
        }
    }
    
    /// KVO
    
    func registerObserve() {
        
        kvoController.observe(authParam,
                              keyPaths: ["realName", "idCard","idCardFront", "idCardBack", "handIdCard"],
                              options: .new)
        { [weak self] (_, object, change) in
            
            let model = object as! APRealNameAuthRequest
            if  model.realName.count > 0 &&
                model.idCard.count > 0 &&
                model.idCardFront != nil &&
                model.idCardBack != nil &&
                model.handIdCard != nil
                {
                self?.authSubmitCell.isEnabled = true
            }
            else {
                self?.authSubmitCell.isEnabled = false
            }
            
        }
    }
    
    /// 点击确认按钮
    override func commit() {
        
        if CPCheckAuthInputInfoTool.evaluateIsLegalName(withName: authParam.realName) {
            view.makeToast("姓名请填写中文")
            return
        }
        
        if authParam.realName.count > 30 {
            view.makeToast("姓名长度出错")
            return
        }
        
        if !CPCheckAuthInputInfoTool.checkIsIDCard(withIDCard: authParam.idCard) {
            view.makeToast("身份证号格式错误，请输入正确的身份证号")
            return
        }
        
        if !CPCheckAuthInputInfoTool.checkIsMoreThan18(withCardNo: authParam.idCard) {
            view.makeToast("平台用户必须年满18周岁，请重新输入")
            return
        }
        
        authSubmitCell.loading(isLoading: true)
        APAuthHttpTool.realNameAuth(params: authParam, success: { (response) in
            self.authSubmitCell.loading(isLoading: false, isComplete: {
                self.controllerTransition()
            })
        }) { (error) in
            self.authSubmitCell.loading(isLoading: false)
            self.view.makeToast(error.message)
        }
    }
    
    func controllerTransition() {
        if let _ = processView() {
            authNavigation()?.pushViewController(APSettlementCardAuthViewController(), animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension APRealNameAuthViewController {
    
    func setUpUI() {
        
        layoutFormCellView()
        initCollectionViewData()
        layoutViews()
    }
    
    /// 重新布局子视图
    func layoutViews() {
        
        authHeadMessage.text = "请将身份证放在识别扫描框内，确保证件完整拍摄、无污损、无光斑。"
        
        collectionView?.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(cellHeight * (gridViewModels.count / 2))
        }
        
        formCellView.snp.updateConstraints({ (make) in
            make.height.equalTo(103)
        })
        
        inputTipView.snp.updateConstraints { (make) in
            make.height.equalTo(20)
        }
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(inputTipView)
        }
    }
    
    
    /// 布局表单内容
    func layoutFormCellView() {
        
        formCellView.addSubview(realNameCell)
        formCellView.addSubview(idCardNoCell)
        realNameCell.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(50)
        }
        idCardNoCell.snp.makeConstraints { (make) in
            make.top.equalTo(realNameCell.snp.bottom).offset(1)
            make.right.left.height.equalTo(realNameCell)
        }
    }
    
    /// 初始化collectionView DataSource
    func initCollectionViewData() {
        
        idCardFront.bottomMessage = "身份证正面"
        idCardFront.placeHolderImageName = "auth_idCardFront_normal"
        gridViewModels.append(idCardFront)
        
        idCardResver.bottomMessage = "身份证反面"
        idCardResver.placeHolderImageName = "auth_idCardResver_normal"
        gridViewModels.append(idCardResver)
        
        holdIdCard.bottomMessage = "手持身份证半身照片"
        holdIdCard.placeHolderImageName = "auth_holdIdCard_normal"
        gridViewModels.append(holdIdCard)
        
        example.bottomMessage = "示例"
        example.gridState = .other
        example.placeHolderImageName = "auth_example"
        gridViewModels.append(example)
    }
}

extension APRealNameAuthViewController: APCameraViewControllerDelegate {
    
    func cameraViewController(_ : APCameraViewController, didFinishPickingImage image: UIImage) {
        updateGridImage(image: image)
    }
    
    func ocrCameraIDCardResult(IDCard result: APOCRIDCard) {
        
        updateGridImage(image: result.image)
        
        if let text = result.name {
            realNameCell.textField.text = text
        }
        if let text = result.number {
            idCardNoCell.textField.text = text
        }
    }
    
    func updateGridImage(image: UIImage?) {
        if let model = currentGridModel {
            model.image = image
            collectionView?.performBatchUpdates({
                let indexPath = IndexPath.init(item: gridViewModels.index(of: model)!, section: 0)
                collectionView?.reloadItems(at:[indexPath as IndexPath])
            }, completion: nil)
        }
    }
}
