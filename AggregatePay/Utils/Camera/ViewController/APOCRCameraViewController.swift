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
    private var currTouchPoint = CGPoint.zero
    
    var ocrDelegate: APOCRCameraViewControllerDelegate?
    private var captureManager: SCCaptureSessionManager!
    private var drawView: CameraDrawView!
    private var focusImageView: UIImageView!
    private var centerLabel: UILabel!
    private var slider: SCSlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSessionManager()
        setUpUI()
        showTextInfo()
        addFocusView()
        relayoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureManager.session.startRunning()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureManager = nil
    }
    
    fileprivate func setUpSessionManager() {
        if !isSimulator() {
            
            TREC_StartUP(TREC_GetEngineTimeKEY());
            captureManager = SCCaptureSessionManager()
            captureManager.setCardType(scanCardType, mode: true)
            captureManager.delegate = self
            captureManager.configure(withParentLayer: view, previewRect: view.frame)
            captureManager.isPortrait = false
        }
    }
    
    fileprivate func setUpUI() {
        
        if !isSimulator() {
            
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
    }
    
    fileprivate func addFocusView() {
        focusImageView = UIImageView.init(image: UIImage.init(named: "camera_focus"))
        focusImageView.alpha = 0
        view.addSubview(focusImageView)
    }
    
   fileprivate  func showTextInfo() {
        if TIDCARD2 == scanCardType {
            centerLabel.text = "请将身份证正面置于此区域  并尝试对齐边缘"
        } else if(TIDCARDBACK == scanCardType) {
            centerLabel.text = "请将身份证反面置于此区域  并尝试对齐边缘"
        } else if(TIDCARDBACK == scanCardType) {
            centerLabel.text = "请将银行卡置于此区域  并尝试对齐边缘"
        }
    }
    
   fileprivate func addSlider() {
        let width: CGFloat = 40
        let height: CGFloat = previewRect.size.height - 100
        let rect = CGRect.init(x: (previewRect.size.width - width), y: (previewRect.size.height + leftViewWidth + rightViewWidth + padding - height) / 2, width: width, height: height)
        slider? = SCSlider.init(frame: rect, direction: SCSliderDirectionVertical)
        slider?.alpha = 0.0
        slider?.minValue = 1
        slider?.maxValue = 3
        weak var weakSelf = self
        slider?.buildDidChangeValueBlock({ (value) in
            weakSelf?.captureManager.pinchCameraView(withScalNum: value)
        })
        slider?.buildTouchEnd({ (value, isTouchEnd) in
            weakSelf?.setSliderAlpha(isTouchEnd: isTouchEnd)
        })
    }
    
    fileprivate func setSliderAlpha(isTouchEnd: Bool) {
        if let scSlider = slider {
            scSlider.isSliding = !isTouchEnd
            
            if scSlider.alpha != 0.0 && !scSlider.isSliding {
                let delayInSeconds: Double = 3.88
                DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                    if scSlider.alpha != 0.0 && scSlider.isSliding {
                        UIView.animate(withDuration: 0.3, animations: {
                            scSlider.alpha = 0.0
                        })
                    }
                }
            }
        }
        
    }
    
   func relayoutViews() {
       view.bringSubview(toFront: leftToolView)
       view.bringSubview(toFront: rightToolView)
    
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
        
        if !isSimulator() {
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
                
                backAction()
            } else {
                captureManager.isRun1 = false
            }
        }
    }
    
    func didBankCardScanOCR(image: UIImage, rect: CGRect) {
        
        if !isSimulator() {
            
            let supportEngine = TREC_SetSupportEngine(TIDBANK)
            if supportEngine != 1 {
                view.makeToast("引擎不支持")
                return
            }
            
            let dict = APOCRImageTool.handleBankCardData(image, rect: rect, drawView: drawView)
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
                backAction()
            } else {
                captureManager.isRun1 = false
            }
        }
    }
    
   private func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }
}

extension APOCRCameraViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        alphaTimes = -1
        let touch = touches.first
        currTouchPoint = (touch?.location(in: view))!
        if !captureManager.previewLayer.bounds.contains(currTouchPoint) {
            return
        }
        captureManager.focus(in: currTouchPoint)
        focusImageView.center = currTouchPoint
        focusImageView.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
            self.focusImageView.alpha = 1
            self.focusImageView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .allowUserInteraction, animations: {
                self.focusImageView.alpha = 0.0
            }, completion: nil)
        }
    }
}
