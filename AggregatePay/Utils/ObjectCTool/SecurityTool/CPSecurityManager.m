//
//  CPSecurityManager.m
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/18.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

#import "CPSecurityManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "CPRSACryptor.h"
#import "CPCipherAES.h"
#import "CPBase64.h"

@implementation CPSecurityManager

+ (NSString *)cp_aesEncryptWithParm:(NSString *)parm {
    if (parm != nil && ![parm isEqualToString:@""]) {
        parm = aesEncryptString(parm, AES_KEY);
        return parm;
    }
    return parm;
}

+ (NSString *)cp_aesDecryptWithParm:(NSString *)parm {
    if (parm != nil && ![parm isEqualToString:@""]) {
        parm = aesDecryptString(parm, AES_KEY);
        return parm;
    }
    return parm;
}


+ (NSString *)cp_sha1withParam:(NSString *)param {
    if (param == nil || [param isEqualToString:@""]) {
        return param;
    }
    
    const char *cstr = [param cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr
                                  length:param.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes,(CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (NSString *)cp_custumeSignaWithParams:(NSDictionary *)params
                             privateKey:(NSString *)privateKey {
    
    if (params == nil) {
        return @"";
    }
    //如果字段值为空则去除
    NSMutableDictionary *newParamsDic = [NSMutableDictionary dictionaryWithDictionary:params];
    for (NSString *key in newParamsDic.allKeys) {
        if (newParamsDic[key] == nil ||
            [newParamsDic[key] isEqualToString:@""]) {
            [newParamsDic removeObjectForKey:key];
        }
    }
    //对参数进行排序 按ASCII码递增排序(首字母)，首字母一样，则按第二个字母排序
    NSStringCompareOptions comparisonOptions =
    NSLiteralSearch|
    NSNumericSearch|
    NSWidthInsensitiveSearch|
    NSForcedOrderingSearch;
    
    NSArray *sortArray = [newParamsDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1, NSString * obj2) {
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2
                     options:comparisonOptions
                       range:range];
    }];
    
    //拼接后的字符串
    NSMutableString *appendStr = [NSMutableString string];
    for (int i = 0; i < sortArray.count; i++) {
        if (i == 0) {
            [appendStr appendString:[NSString stringWithFormat:@"%@=%@",
                                     sortArray[i],
                                     newParamsDic[sortArray[i]]]];
        }else{
            [appendStr appendString:[NSString stringWithFormat:@"&%@=%@",
                                     sortArray[i],
                                     newParamsDic[sortArray[i]]]];
        }
    }
    //rsa私钥签名
    NSString *signa = [CPRSACryptor cp_signContent:appendStr privateKey:privateKey];
    return signa;
}

@end
