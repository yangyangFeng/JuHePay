//
//  BBRSACryptor.m
//  BBRSACryptor-ios
//
//  Created by liukun on 14-3-21.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "CPRSACryptor.h"
#import "CPBase64.h"


#define DocumentsDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define OpenSSLRSAKeyDir [DocumentsDir stringByAppendingPathComponent:@".openssl_rsa"]
#define OpenSSLRSAPublicKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"bb.publicKey.pem"]
#define OpenSSLRSAPrivateKeyFile [OpenSSLRSAKeyDir stringByAppendingPathComponent:@"bb.privateKey.pem"]


#define PADDING_GENERATE_RSA_SIZE  512   //密钥长度
#define PADDING_PRIVATE_FLOAT_LEN  (PADDING_GENERATE_RSA_SIZE/8)
#define PADDING_PUBLIC_FLOAT_LEN   (PADDING_PRIVATE_FLOAT_LEN-11)

@implementation CPRSACryptor


+ (CPRSACryptor *)sharedInstance {
    static CPRSACryptor *rsaCryptor_bka = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rsaCryptor_bka = [[self alloc] init];
    });
    return rsaCryptor_bka;
}

//重写父类的生成证书的方法
- (BOOL)generateRSAKeyPairWithKeySize:(int)keySize
{
    if (NULL != _rsa)
    {
        RSA_free(_rsa);
        _rsa = NULL;
    }
    _rsa = RSA_generate_key(keySize,RSA_F4,NULL,NULL);
    assert(_rsa != NULL);
    
    const char *publicKeyFileName = [OpenSSLRSAPublicKeyFile cStringUsingEncoding:NSASCIIStringEncoding];
    const char *privateKeyFileName = [OpenSSLRSAPrivateKeyFile cStringUsingEncoding:NSASCIIStringEncoding];
    
    //写入私钥和公钥
    RSA_blinding_on(_rsa, NULL);
    
    BIO *priBio = BIO_new_file(privateKeyFileName, "w");
    PEM_write_bio_RSAPrivateKey(priBio, _rsa, NULL, NULL, 0, NULL, NULL);
    
    BIO *pubBio = BIO_new_file(publicKeyFileName, "w");
    
    //xyd:----------(这个地方与父类的不一样)
    PEM_write_bio_RSA_PUBKEY(pubBio, _rsa);
    
    
    BIO_free(priBio);
    BIO_free(pubBio);
    
    //分别获取公钥和私钥
    _rsaPrivate = RSAPrivateKey_dup(_rsa);
    assert(_rsaPrivate != NULL);
    
    _rsaPublic = RSAPublicKey_dup(_rsa);
    assert(_rsaPublic != NULL);
    
    if (_rsa && _rsaPublic && _rsaPrivate)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)importRSAKeyWithType:(KeyType)type {
    FILE *file;
    NSString *keyName = ((type == KeyTypePublic) ? @"public_key" : @"private_key");
    NSString *keyPath = nil;
    if ([keyName isEqualToString:@"public_key"]) {
        keyPath = OpenSSLRSAPublicKeyFile;
    }
    else {
        keyPath = OpenSSLRSAPrivateKeyFile;
    }
    file = fopen([keyPath UTF8String], "rb");
    if (NULL != file) {
        if (type == KeyTypePublic) {
            _rsa = PEM_read_RSA_PUBKEY(file,
                                       NULL,
                                       NULL,
                                       NULL);
            assert(_rsa != nil);
        }
        else {
            _rsa = PEM_read_RSAPrivateKey(file,
                                          NULL,
                                          NULL,
                                          NULL);
            assert(_rsa != NULL);
        }
        fclose(file);
        return (_rsa != NULL) ? YES : NO;
    }
    return NO;
}


- (NSString *)privateSignContent:(NSString *)content {
    if (![self importRSAKeyWithType:KeyTypePrivate]) {
        return nil;
    }
    if (!_rsa) {
        NSLog(@"please import private key first");
        return nil;
    }
    const char *message = [content cStringUsingEncoding:NSUTF8StringEncoding];
    int messageLength = (int)strlen(message);
    unsigned char *sig = (unsigned char *)malloc(256);
    unsigned int sig_len;
    
    unsigned char sha1[20];
    SHA1((unsigned char *)message, messageLength, sha1);
    
    int rsa_sign_valid = RSA_sign(NID_sha1,
                                  sha1,
                                  20,
                                  sig,
                                  &sig_len,
                                  _rsa);
    if (rsa_sign_valid == 1) {
        NSData* data = [NSData dataWithBytes:sig length:sig_len];
        NSString * base64String = [data base64EncodedStringWithOptions:0];
        free(sig);
        return base64String;
    }
    free(sig);
    return nil;
}


#pragma mark ----------提供被调用接口-----------


+ (BOOL)cp_generateRSAKeyPair{
    BBRSACryptor *rsaCryptor = [CPRSACryptor sharedInstance];
    return [rsaCryptor generateRSAKeyPairWithKeySize:PADDING_GENERATE_RSA_SIZE];
}

+ (BOOL)cp_importRSAPublicKeyBase64:(NSString *)publicKey {
    BBRSACryptor *rsaCryptor = [CPRSACryptor sharedInstance];
    return [rsaCryptor importRSAPublicKeyBase64:publicKey];
}

+ (BOOL)cp_importRSAPrivateKeyBase64:(NSString *)privateKey{
    BBRSACryptor *rsaCryptor = [CPRSACryptor sharedInstance];
    return [rsaCryptor importRSAPrivateKeyBase64:privateKey];
}

+ (NSString *)cp_base64EncodedPublicKey {
    BBRSACryptor *rsaCryptor = [CPRSACryptor sharedInstance];
    return [rsaCryptor base64EncodedPublicKey ];
}

+ (NSString *)cp_base64EncodedPrivateKey{
    BBRSACryptor *rsaCryptor = [CPRSACryptor sharedInstance];
    return [rsaCryptor base64EncodedPrivateKey];
}

+ (NSString *)cp_signContent:(NSString *)content privateKey:(NSString *)privateKey {
    if([CPRSACryptor cp_importRSAPrivateKeyBase64:privateKey]) {
        CPRSACryptor *rsaCryptor = [CPRSACryptor sharedInstance];
        return [rsaCryptor privateSignContent:content];
    }
    return nil;
}



@end





