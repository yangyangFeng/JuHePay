//
//  BKABase64.h
//  安全案例
//
//  Created by BlackAnt on 17/4/20.
//  Copyright © 2017年 cne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 二次封装GTMBase64
 */

@interface CPBase64 : NSObject

+ (NSData *)cp_encodeData:(NSData *)data ;
+ (NSData *)cp_decodeData:(NSData *)data ;

+ (NSData *)cp_dataDecodeString:(NSString *)string;
+ (NSString *)cp_stringByEncodingData:(NSData *)data;

@end
