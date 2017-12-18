//
//  CPRSAEncrpTool.m
//  中汇支付
//
//  Created by cqh on 14/12/24.
//  Copyright (c) 2014年 Chepay. All rights reserved.
//

#import "CPRSAEncrpTool.h"
#import "BBRSACryptor.h"
#import "GTMBase64.h"   

@interface CPRSAEncrpTool()
@property (nonatomic ,strong) BBRSACryptor *rsaCryptor;

@end
@implementation CPRSAEncrpTool

+ (instancetype) rsaEncrpTool {
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.rsaCryptor = [[BBRSACryptor alloc] init];
    }
    return self;
}


- (NSString *) rsaEncryptWithPublicKey:(NSString *)publicKey withKeyWords:(NSString *)keyWords {
    BOOL importSuccess = [self.rsaCryptor importRSAPublicKeyBase64:publicKey];

    if(importSuccess) {
        return [self rsaEncryptWithSecert:keyWords];
    }
    
    return nil;
}


- (NSString *) rsaEncryptWithSecert:(NSString *)secret{
    NSData *cipherData = [self.rsaCryptor encryptWithPublicKeyUsingPadding:RSA_PKCS1_PADDING plainData:[secret dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *cipherString = [GTMBase64 stringByEncodingData:cipherData];
    return cipherString;
    
}
@end
