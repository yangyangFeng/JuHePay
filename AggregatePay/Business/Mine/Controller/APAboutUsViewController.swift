//
//  APAboutUsViewController.swift
//  AggregatePay
//
//  Created by cnepayzx on 2017/12/13.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

class APAboutUsViewController: APMineBaseViewController {

    var data : APAboutUsResponse?
    var cells : [APAboutMsgCell] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        
        loadData()
        // Do any additional setup after loading the view.
    }

    func initSubviews(){
        let logoIcon = UIImageView()
        logoIcon.theme_image = ["system_logo_icon"]
        logoIcon.backgroundColor = UIColor.clear
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 18)
        title.textColor = UIColor.init(hex6: 0xc8a556)
        title.text = "聚合财富"
        
        view.addSubview(logoIcon)
        view.addSubview(title)
        logoIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(92)
            make.centerX.equalTo(view.snp.centerX).offset(0)
            make.top.equalTo(58)
        }
        title.snp.makeConstraints { (make) in
            make.top.equalTo(logoIcon.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX).offset(0)
            make.height.equalTo(22)
        }
        //getAboutUsInfo
        
        let titles : [String] = ["版本号", "服务热线", "官网"]
        let msgs : [String] = [AppVersion as! String,
                               "400-091-9866",
                               "www.cnepay.com"]
        for i in 0...2 {
            let cell = APAboutMsgCell.init(titles[i], msgs[i], bgType: (i%2 == 0) ? .APAboutMsgCell_Gray : .APAboutMsgCell_White)
            view.addSubview(cell)
            cells.append(cell)
            cell.snp.makeConstraints({ (make) in
                make.top.equalTo(title.snp.bottom).offset(55+i*40)
                make.left.right.equalTo(0)
                make.height.equalTo(40)
            })
        }
        
        let checkVersionBtn = APSubmitFormsCell()
        checkVersionBtn.button.setTitle("检查更新", for: UIControlState.normal)
        checkVersionBtn.button.addTarget(self, action: #selector(checkoutBtnDidAction), for: UIControlEvents.touchUpInside)


        view.addSubview(checkVersionBtn)
        checkVersionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(250)
            make.height.equalTo(41)
            make.left.equalTo(35)
            make.right.equalTo(-35)
        }
    }
    
    func loadData(){
        view.AP_loadingBegin()
        let param = APAboutUsRequest()
        APMineHttpTool.aboutInfo(param, success: { (res) in
            self.view.AP_loadingEnd()
            self.data = res as? APAboutUsResponse
            let cell_1 = self.cells[1]
            let cell_2 = self.cells[2]
            
            cell_1.msgLabel.text = self.data?.serviceHotline
            cell_2.msgLabel.text = self.data?.officialWebsiteAddress
        }) { (error) in
            self.view.AP_loadingEnd()
            self.view.makeToast(error.message)
        }
    }

    @objc func checkoutBtnDidAction()
    {
        let param = APCheckAppVerisonRequest()
        param.systemType = "1"
        APMineHttpTool.updateApp(param, success: { (baseResp) in
            let resp = baseResp as! APCheckAppVerisonResponse
            APVersionUpgradeController.show(minVersion: resp.minVersionNo,
                                            maxVersion: resp.lastVersionNo,
                                            content: resp.lastVersionContent,
                                            storeUrl: resp.lastVersionDownloadUrl)
        }) { (baseError) in
            self.view.makeToast(baseError.message)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class APAboutMsgCell: UIView {
    
    let titleLabel = UILabel()
    let msgLabel = UILabel()
    
    enum APAboutMsgCellType : String{
        case APAboutMsgCell_White = "#FFF"
        case APAboutMsgCell_Gray = "#fafafa"
    }
    
    init(_ title : String, _ msg : String, bgType : APAboutMsgCellType) {
        super.init(frame: CGRect.zero)
        
        theme_backgroundColor = [bgType.rawValue]
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.init(hex6: 0x999999)
        titleLabel.textAlignment = .left
        titleLabel.text = title
        
        msgLabel.font = UIFont.systemFont(ofSize: 14)
        msgLabel.textColor = UIColor.init(hex6: 0x484848)
        msgLabel.textAlignment = .left
        msgLabel.text = msg
        
        addSubview(titleLabel)
        addSubview(msgLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(20)
        }
        msgLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(110)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
