//
//  BBRSACryptor.h
//  BBRSACryptor-ios
//
//  Created by liukun on 14-3-21.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

//#import <StateMachine/openssl/BBRSACryptor.h>
#import "BBRSACryptor.h"
typedef enum : NSUInteger{
    KeyTypePublic,
    KeyTypePrivate
}KeyType;

@interface CPRSACryptor : BBRSACryptor

+ (CPRSACryptor *)sharedInstance;

/** 生成密钥对 */
+ (BOOL)cp_generateRSAKeyPair;

/** 转换公钥格式 */
+ (BOOL)cp_importRSAPublicKeyBase64:(NSString *)publicKey;

/** 转换私钥格式 */
+ (BOOL)cp_importRSAPrivateKeyBase64:(NSString *)privateKey;

/** 获取公钥字符串 */
+ (NSString *)cp_base64EncodedPublicKey;

/** 获取私钥字符串 */
+ (NSString *)cp_base64EncodedPrivateKey;

/** 利用私钥签名 */
+ (NSString *)cp_signContent:(NSString *)content privateKey:(NSString *)privateKey;

@end


















