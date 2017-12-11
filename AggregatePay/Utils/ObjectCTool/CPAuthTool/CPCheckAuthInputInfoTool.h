//
//  CPCheckAuthInputInfoTool.h
//  CnepayV2
//
//  Created by Cnepay on 15/12/16.
//  Copyright (c) 2015年 Cnepay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPCheckAuthInputInfoTool : NSObject

/**
 *  验证密码
 *  @param password 密码内容
 *  @return 校验是否成功
 */
+ (BOOL) evaluatePassword:(NSString *)password;

/**
 *  验证手机号码的
 *  @param phoneNumber 手机号
 *  @return 校验是否成功
 */
+ (BOOL) evaluatePhoneNumber:(NSString *)phoneNumber;


/**
 *  验证真实姓名
 *  @param name 真实姓名
 *  @return 校验是否成功
 */

+ (BOOL) evaluateIsLegalNameWithName:(NSString *)name;
+ (BOOL) evaluateIsChineseAndEnglishNameWithName:(NSString *)name;

/**
 *  验证银行卡长度
 *  @param bankNo 银行卡
 *  @return 校验是否成功
 */
+ (BOOL) evaluateBankNo:(NSString *)bankNo;



/**
 *  验证营业执照号
 *  @param businessLicense 营业执照号
 *  @return 校验是否成功
 */

+ (BOOL) evaluateBusinessLicense:(NSString *)businessLicense;



/**
 *  验证身份证号
 *  @param idNo 身份证号
 *  @return 校验是否成功
 */

+ (BOOL) checkIsIDCardWithIDCard:(NSString *)idNo;

/**
 *  验证年龄是否大于18岁
 *  @param cardNo 身份证号
 *  @return 校验是否成功
 */
+ (BOOL)checkIsMoreThan18WithCardNo:(NSString *)cardNo;
@end
