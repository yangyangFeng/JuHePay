//
//  APSharedUtil.m
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/12.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

#import "APSharedUtil.h"
#import <WXApi.h>

@interface APSharedUtil() <WXApiDelegate>

@property (copy, nonatomic) CPSharedResultBlock resultBlock;

@end

@implementation APSharedUtil

+ (APSharedUtil *)sharedInstance {
    static APSharedUtil *sharedUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtil = [[APSharedUtil alloc] init];
    });
    return sharedUtil;
}

+ (void)ap_sharedWithImage:(UIImage *)image
                   atScens:(int)scene
               resultBlock:(CPSharedResultBlock)block {
    [[APSharedUtil sharedInstance] setResultBlock:block];
    [[APSharedUtil sharedInstance] ap_shared:image scene:scene];
}

+ (BOOL)ap_openUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[APSharedUtil sharedInstance]];
}

+ (void)ap_register:(NSString *)apiKey {
    [WXApi registerApp:apiKey];
}

- (void)ap_shared:(UIImage *)image scene:(int)scene {
    
    if (![WXApi isWXAppInstalled]) {
        self.resultBlock(@"您未安装微信");
        return;
    }
    if (![WXApi isWXAppSupportApi]) {
        self.resultBlock(@"您的微信版本过低");
        return;
    }
    
    UIImage *thumbImage = [self imageWithImage:image scaledToSize:CGSizeMake(50, 50)];
    NSData *sharedImage = UIImageJPEGRepresentation(image, 0.5);
    
    SendMessageToWXReq* sendMessageReq = [[SendMessageToWXReq alloc] init];
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *imageObject = [WXImageObject object];
    [imageObject setImageData:sharedImage];
    [message setThumbImage:thumbImage];
    [message setMediaObject:imageObject];
    [sendMessageReq setBText:NO];
    [sendMessageReq setMessage:message];
    [sendMessageReq setScene:scene];
    [WXApi sendReq:sendMessageReq];
}

-(void) onResp:(BaseResp*)resp {
    self.resultBlock(resp.errStr);
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size
{
    UIImage *resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return resultImage;
}

@end
