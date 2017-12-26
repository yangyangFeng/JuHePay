//
//  CPMD5EncrpTool.h
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/26.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 由于MD5加密是不可逆的,多用来进行验证
 */
@interface CPMD5EncrpTool : NSObject
/** 32位小写 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;
/** 32位大写 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
/** 16为大写 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
/** 16位小写 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;
    

@end
