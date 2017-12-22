//
//  APOCRCameraViewController.swift
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/21.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

protocol APOCRCameraViewControllerDelegate: APCameraViewControllerDelegate {
    func ocrCameraBankCardResult(bankCard result: APOCRBankCard)
    func ocrCameraIDCardResult(IDCard result: APOCRIDCard)
}

class APOCRCameraViewController: APCameraViewController {
    
    /// ocrsdk 秘钥 暂时没有用
    public var timeKey: String?
    private var isClose = false
    
    private var alphaTimes: Int = -1
    
    var ocrDelegate: APOCRCameraViewControllerDelegate?
    private var captureManager: SCCaptureSessionManager!
    private var drawView: CameraDrawView!
    private var focusImageView: UIImageView!
    private var centerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSessionManager()
        setUpUI()
        addFocusView()
        showTextInfo()
        relayoutViews()
        captureManager.session.startRunning()
    }
    
    deinit {
        captureManager = nil
    }
    
    fileprivate func setUpSessionManager() {
        
        TREC_StartUP(TREC_GetEngineTimeKEY());
        
        captureManager = SCCaptureSessionManager()
        captureManager.setCardType(scanCardType, mode: true)
        captureManager.delegate = self
        captureManager.configure(withParentLayer: view, previewRect: view.frame)
        captureManager.isPortrait = false
    }
    
    fileprivate func setUpUI() {
        
        drawView = CameraDrawView.init(frame: view.frame)
        drawView.isPortrait = false
        drawView.backgroundColor = UIColor.clear
        drawView.setPreSize(view.frame.size)
        
        centerLabel = UILabel.init(frame: view.frame)
        centerLabel.textColor = UIColor.white
        centerLabel.font = UIFont.systemFont(ofSize: 14)
        centerLabel.adjustsFontSizeToFitWidth = true
        centerLabel.backgroundColor = UIColor.clear
        centerLabel.textAlignment = .center
        centerLabel.numberOfLines = 0
        centerLabel.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
        view.addSubview(centerLabel)
        view.addSubview(drawView)
        captureManager.setValuePoint(drawView.getBeginPoint(), end: drawView.getEndPoint())
    }
    
    fileprivate func addFocusView() {
        focusImageView = UIImageView.init(image: UIImage.init(named: "camera_ensureBtn"))
        view.addSubview(focusImageView)
        
        #if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
            let device = AVCaptureDevice.default(for: .video)
            if device && device?.isFocusPointOfInterestSupported {
                device?.addObserver(self, forKeyPath: "adjustingFocus", options: .New|.Old, context: nil)
            }
        #endif
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if "adjustingFocus" == keyPath {
//            if Int(change![NSKeyValueChangeKey.newKey]) != 1 {
//                alphaTimes = -1
//            }
        }
    }
    
    func showTextInfo() {
        if TIDCARD2 == scanCardType {
            centerLabel.text = "请将身份证正面置于此区域  并尝试对齐边缘"
        } else if(TIDCARDBACK == scanCardType) {
            centerLabel.text = "请将身份证反面置于此区域  并尝试对齐边缘"
        } else if(TIDCARDBACK == scanCardType) {
            centerLabel.text = "请将银行卡置于此区域  并尝试对齐边缘"
        }
    }
    
   func relayoutViews() {
       view.bringSubview(toFront: leftToolView)
       view.bringSubview(toFront: rightToolView)
    
//        leftToolView.snp.remakeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.bottom.equalTo(drawView.snp.top).offset(-padding)
//        }
//        rightToolView.snp.remakeConstraints { (make) in
//            make.bottom.right.left.equalToSuperview()
//            make.top.equalTo(drawView.snp.bottom).offset(padding)
//        }
    }
}

extension APOCRCameraViewController: SCCaptureSessionManagerProtocol {
    func didCapturePhoto(_ Image: UIImage!, rect: CGRect) {
        if scanCardType == TIDBANK {
            didBankCardScanOCR(image: Image, rect: rect)
        } else {
            didIDCardScanOCR(image: Image, rect: rect)
        }
    }
    
    func didIDCardScanOCR(image: UIImage, rect: CGRect) {
        
        let support = TREC_SetSupportEngine(TIDCARD2)
        if support != 1 {
            print("引擎不支持")
            return
        }
        let dict = APOCRImageTool .handleIDCardData(image, rect: rect, drawView: drawView)
        let ret: Int = dict!["ret"] as! Int
        let isReturnOk: Int = dict!["isReturnOk"] as! Int
        if ret != 0 && ret != 1 {
            captureManager.showErrorInfo(Int32(ret), delegate: self.ocrDelegate)
            dismiss(animated: true, completion: nil)
            return
        }
        if isReturnOk != 0 && isClose == false {
            
            let targetImage = image
            
            if TIDCARD2 == TREC_GetCardType() {
                
                let idCard = APOCRIDCard()
                idCard.image = targetImage
                idCard.name = TREC_GetFieldString(NAME)
                idCard.gender = TREC_GetFieldString(SEX)
                idCard.birthday = TREC_GetFieldString(BIRTHDAY)
                idCard.adress = TREC_GetFieldString(ADDRESS)
                idCard.number = TREC_GetFieldString(NUM)
                idCard.isBack = false
                ocrDelegate?.ocrCameraIDCardResult(IDCard: idCard)
                
            } else if TIDCARDBACK == TREC_GetCardType() {
                
                let idCard = APOCRIDCard()
                idCard.backImage = targetImage
                idCard.validDate = TREC_GetFieldString(PERIOD)
                ocrDelegate?.ocrCameraIDCardResult(IDCard: idCard)
            }
        }
    }
    
    func didBankCardScanOCR(image: UIImage, rect: CGRect) {
        let supportEngine = TREC_SetSupportEngine(TIDBANK)
        if supportEngine != 1 {
            view.makeToast("引擎不支持")
            return
        }
        
        let dict = APOCRImageTool.handleIDCardData(image, rect: rect, drawView: drawView)
        let ret: Int = dict!["ret"] as! Int
        let isReturnOk: Int = dict!["isReturnOk"] as! Int
        
        if ret != 0 && ret != 1 {
            captureManager.showErrorInfo(Int32(ret), delegate: self.ocrDelegate)
            dismiss(animated: true, completion: nil)
            return
        }
        
        if isReturnOk != 0 && isClose == false {

            let bankCard = APOCRBankCard()
            bankCard.bankName = TBANK_GetBankInfoString(T_GET_BANK_NAME)
            bankCard.cardNum = TBANK_GetBankInfoString(T_GET_BANK_NUM)
            bankCard.bankOrgcode = TBANK_GetBankInfoString(T_GET_BANK_ORGCODE)
            bankCard.cardName = TBANK_GetBankInfoString(T_GET_CARD_NAME)
            bankCard.cardType = TBANK_GetBankInfoString(T_GET_BANK_CLASS)
            bankCard.bankCardImage = image
            ocrDelegate?.ocrCameraBankCardResult(bankCard: bankCard)
        }
    }
}
