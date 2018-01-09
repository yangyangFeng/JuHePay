//
//  APKeyboardCompositionView.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/7.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit
/**
 * 用于组合键盘和显示框的视图
 * 1、组合键盘视图和显示框视图的布局
 * 2、控制键盘和显示框之间的传递关系（MVC-C）
 */

protocol APKeyboardCompositionViewDelegate: NSObjectProtocol {
    func didKeyboardConfirm(totalAmount: String, model: Any)
}

typealias APDidKeyboardConfirmItem = (_ param: String) -> Void

class APKeyboardCompositionView: UIView, APKeyboardViewDelegate{
    
    //输入规则
    private let inputRules: APKeyboardInputRules = APKeyboardInputRules()
    
    //代理
    weak var delegate: APKeyboardCompositionViewDelegate?
    
    //键盘区域
    var keyboardView: APKeyboardView?
    
    //显示区
    var displayView: APDisplayView?
    
    init() {
        super.init(frame: CGRect.zero)
        
        displayView = getDisplayView()
        
        keyboardView = getKeyboardView()
        keyboardView!.keyboardDelegate = self
        
        addSubview(displayView!)
        addSubview(keyboardView!)
        
        displayView?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(self.snp.height).multipliedBy(0.25)
        }
        keyboardView?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(displayView!.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ---- 接口扩展
    
    /** 返回键盘视图（允许继承APKeyboardView后自定义样式） */
    func getKeyboardView() -> APKeyboardView {
        return APKeyboardView()
    }
    
    /** 返回显示视图（允许继承APDisplayView后自定义样式） */
    func getDisplayView() -> APDisplayView {
        return APDisplayView()
    }
    
    /** 键盘触发提交按钮时传递的参数（子类提供）*/
    func confirmParam() -> Any {
        return ""
    }
    
    func ap_remove() {
        
    }
    
    //MARK: ---- APKeyboardViewDelegate(键盘代理方法)
    
    
    /** 键盘点击数字按钮 */
    func didKeyboardNumItem(num: String) {
        //获取当前屏显的金额总数
        let totalAmount: String = (displayView?.outputDisplayNumValue())!
        //进行输入规则验证
        let resultStr = inputRules.inputRules(display: totalAmount, num: num)
        //把验证后的返回结果传入到屏显示图进行显示
        displayView!.inputDisplayNumValue(num: resultStr)
    }

    /** 键盘点击删除按钮 */
    func didKeyboardDeleteItem() {
        //获取当前屏显的金额总数
        let totalAmount: String = (displayView?.outputDisplayNumValue())!
        //进行删除规则验证
        let resultStr = inputRules.deleteRules(display: totalAmount)
        //把验证后的返回结果传入到屏显示图进行删除
        displayView!.deleteDisplayNumValue(num: resultStr)
    }
    
    /** 键盘点击确定按钮 */
    func didKeyboardConfirmItem() {
        //获取当前屏显的金额总数
        let totalAmount: String = (displayView?.outputDisplayNumValue())!
        //获取点击确认按钮时需要传递给控制器的参数（子类提供）
        let model: Any = confirmParam()
        //通过代理把参数传递给相应的控制器
        delegate?.didKeyboardConfirm(totalAmount: totalAmount, model: model)
    }
}

//MARK:  ----- APKeyboardInputRules(键盘输入规则)

/**
 * 键盘输入规则
 * 后期优化方案（利用队列数据结构进行规则优化）
 */
class APKeyboardInputRules: NSObject {
    
    //最大金额10亿
    let maxAmount: Float = 10000000000.00
    //最小金额1元
    let minAmount: Float = 1.00
    
    /**
     * 金额限制规则
     * 1、金额不得大于maxAmount
     */
    private func isMaxAmountRules(display: String, num: String) -> Bool {
        var isThrough: Bool = true
        let amountStr: String = display
        let isExist :Bool = amountStr.contains(APDecimalPoint)
        if (num != APDecimalPoint && !isExist) {
            let amountSum: Float = Float(amountStr+num)!
            if (amountSum > maxAmount && num != APDecimalPoint) {
                //1、金额不得大于maxAmount
                isThrough = false
            }
        }
        return isThrough
    }
    
    /**
     * 小数点的规则
     * 1、小数点不能重复键入
     * 2、小数点后面最多保留两位
     */
    private func isDecimalRules(display: String, num: String) -> Bool {
        var isThrough: Bool = true
        let amountStr: String = display
        let isExist :Bool = amountStr.contains(APDecimalPoint)
        if (isExist)  {
            if num == APDecimalPoint {
                //1、小数点不能重复键入
                isThrough = false
            }
            else {
                let deRange = amountStr.range(of: APDecimalPoint)
                let backNumber: Substring = amountStr.suffix(from: deRange!.upperBound) as Substring
                
                //小数点后面最多保留两位
                if (backNumber.count >= 2 || (backNumber.count >= 1 && num == "00")) {
                    isThrough = false
                }
            }
        }
        return isThrough
    }
    
    
    /**
     * 输入规则
     * 1、如果首次输入是'.'、'00'、'0'则显示框显示'0.'
     * 2、如果不是首次输入
     *    前验证:(总金额==0、输入数字!='.'、当前金额!='0.'或'0.0')
     *    后验证:(当前金额=='0'并且输入数字!='.'则替换显示框内容为输入的数字，反之正常拼接)
     */
    public func inputRules(display: String, num: String) -> String {
        
        if !self.isMaxAmountRules(display: display, num: num) {
            return display
        }
        
        if !self.isDecimalRules(display: display, num: num) {
            return display
        }
        
        var amount: String = display
        if (amount == "") {
            amount = num
            if num == "." || num == "00" || num == "0" {
                amount = "0."
            }
        }
        else {
            let amountNum: Float = Float(amount + num)!
            if amountNum == 0 && num != APDecimalPoint && (amount != "0." || amount != "0.0"){
                amount = String(amountNum)
            }
            else if amount == "0" && num != APDecimalPoint {
                amount = num
            }
            else {
                amount += num
            }
        }
        return amount
    }
    
    /**
     * 删除规则
     * 1、如果金额长度<=零则表示全部删除成功
     * 2、否则删除金额字符串最后一位数字
     */
    public func deleteRules(display: String) -> String {
        var amount: String = display
        if amount.count <= 0 {
            return amount
        }
        else {
            amount.remove(at: amount.index(before: amount.endIndex))
            return amount
        }
    }
}







