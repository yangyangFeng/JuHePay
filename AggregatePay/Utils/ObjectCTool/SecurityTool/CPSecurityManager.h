//
//  CPSecurityManager.h
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSecurityManager : NSObject


#pragma mark - AES加解密

/** aes加密 */
+ (NSString *)cp_aesEncryptWithParm:(NSString *)parm;

/** aes解密 */
+ (NSString *)cp_aesDecryptWithParm:(NSString *)parm;


#pragma mark - SHA1签名

/** SHA1签名 */
+ (NSString *)cp_sha1withParam:(NSString *)param;

#pragma mark - 自定义签名

/**
 * 自定义签名规则
 * 1、如果字段值为空则去除
 * 2、对参数进行排序 按ASCII码递增排序(首字母)，首字母一样，则按第二个字母排序
 * 3、rsa私钥签名
 */
+ (NSString *)cp_custumeSignaWithParams:(NSDictionary *)params
                             privateKey:(NSString *)privateKey;

@end
