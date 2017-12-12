//
//  CPDateTools.swift
//  framework
//
//  Created by BlackAnt on 2017/12/5.
//  Copyright © 2017年 cne. All rights reserved.
//

import UIKit

/**
 * 日期工具类（常用）
 */
class APDateTools: NSObject {
    
    /**
     * 日期格式
     */
    enum APDateFormat : String {
        case dateFormatDefault = "yyyy-MM-dd HH:mm:ss"
        case deteFormatA = "yyyyMMddHHmmss"
    }
    
    /**
     * 日期转字符串（默认格式）
     * @param date:日期
     */
    static func stringToDate(date: Date) -> String {
        return stringToDate(date: date, dateFormat: APDateFormat.dateFormatDefault)
    }
    
    /**
     * 字符串转日期（默认格式）
     * @param string:字符串
     */
    static func dateToString(string: String) -> Date {
        return dateToString(string: string, dateFormat: APDateFormat.dateFormatDefault)
    }
    
    /**
     * 日期转字符串
     * @param date:日期
     * @param dateFormat:格式
     */
    static func stringToDate(date: Date, dateFormat: APDateFormat) -> String {
        let formatter: DateFormatter = dateFormatter(dateFormat: dateFormat)
        let dateString: String = formatter.string(from: date)
        return dateString
    }
    
    /**
     * 字符串转日期
     * @param string:字符串
     * @param dateFormat:格式
     */
    static func dateToString(string: String, dateFormat: APDateFormat) -> Date {
        let formatter: DateFormatter = dateFormatter(dateFormat: dateFormat)
        let date: Date? = formatter.date(from: string);
        return date!
    }
    
    /**
     * 返回DateFormatter
     * @param dateFormat:格式
     */
    static func dateFormatter(dateFormat: APDateFormat) -> DateFormatter {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter;
    }

}
