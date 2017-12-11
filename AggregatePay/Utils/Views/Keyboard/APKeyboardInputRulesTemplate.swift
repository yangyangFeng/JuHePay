//
//  APInputRulesTemplate.swift
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/11.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

import UIKit

/**
 * 键盘输入规则
 * 后期优化方案（利用队列数据结构进行规则优化）
 */
class APKeyboardInputRulesTemplate: NSObject {
    
    //最大金额1百万
    let maxAmount: Float = 1000000.00
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
                if (backNumber.count >= 2) {
                    //小数点后面最多保留两位
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
