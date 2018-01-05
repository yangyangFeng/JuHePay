//
//  NSString+BKASpecial.h
//  JK3DES
//
//  Created by BlackAnt on 17/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 页面字符串加固显示（屏蔽敏感信息某几个字符）
 */
@interface NSString (CPShield)

/** 身份证号信息做前3后3显示,屏蔽中间位. */
- (NSString *)cp_stringIDCardByReplacing;

/** 结算卡号信息做前6后4显示,屏蔽中间位. */
- (NSString *)cp_stringBankCardByReplacing;


/**
    每个四位加一个空格
 */
- (NSString *)cp_stringBankCardFormat;
@end
