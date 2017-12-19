//
//  BKABase64.m
//  安全案例
//
//  Created by BlackAnt on 17/4/20.
//  Copyright © 2017年 cne. All rights reserved.
//

#import "CPBase64.h"
#import <GTMBase64/GTMBase64.h>

@implementation CPBase64

+ (NSData *)cp_encodeData:(NSData *)data  {
    return [GTMBase64 encodeData:data];
}

+ (NSData *)cp_decodeData:(NSData *)data  {
    return [GTMBase64 decodeData:data];
}

+ (NSData *)cp_dataDecodeString:(NSString *)string {
    return [GTMBase64 decodeString:string];
}
+ (NSString *)cp_stringByEncodingData:(NSData *)data {
    return [GTMBase64 stringByEncodingData:data];
}

@end
