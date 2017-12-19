//
//  CPCipherAES.h
//  CnepayV2
//
//  Created by BlackAnt on 17/5/10.
//  Copyright © 2017年 Cnepay. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AES_KEY @"Vwo7Ry4SpHo2v8+N"

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);
