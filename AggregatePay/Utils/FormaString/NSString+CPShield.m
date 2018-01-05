//
//  NSString+BKASpecial.m
//  JK3DES
//
//  Created by BlackAnt on 17/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSString+CPShield.h"

@implementation NSString (CPShield)

#pragma mark - common

- (NSString *)cp_stringIDCardByReplacing {
    if (self == nil) {
        return @"";
    }
    int location = 3;
    int length = (int)self.length-(location+3);
    return [self stringByReplacingWithLocation:location length:length];
}

- (NSString *)cp_stringBankCardByReplacing {
    if (self == nil) {
        return @"";
    }
    int location = 6;
    int length = (int)self.length-(location+4);
    return [self stringByReplacingWithLocation:location length:length];
}

- (NSString *)cp_stringBankCardFormat
{
    int count = (int)self.length;
    NSMutableString *string = [NSMutableString string];
    for (int i = 1; i <= count; i++) {
        [string appendString:[self substringWithRange:NSMakeRange(i-1, 1)]];
        if (!(i%4)) {
            [string appendString:@" "];
        }
    }
    return string;
}
#pragma mark - private

/**
 * 根据范围获取特殊处理的字符串结果
 */
- (NSString *)stringByReplacingWithLocation:(int)location length:(int)length
{
    NSString *tempStr = nil;
    NSString *resultStr = nil;
    @try {
        tempStr = [self substringWithRange:NSMakeRange(location,length)];
        NSString *symbolStr = [self symbolChangeWithStr:tempStr];
        resultStr = [self stringByReplacingOccurrencesOfString:tempStr withString:symbolStr];
    } @catch (NSException *exception) {
        NSLog(@"[error] -- Exception : %@",exception.reason);
        resultStr = self;
    } @finally {
        return resultStr;
    }
}

/** 
 * 根据参数字符串长度生成对应长度的*号字符串
 */
- (NSString *)symbolChangeWithStr:(NSString *)str {
    int count = (int)str.length;
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < count; i++) {
        [string appendString:@"*"];
    }
    return string;
}

@end
