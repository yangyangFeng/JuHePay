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
    [[APSharedUtil sharedInstance] ap_shared:image scene:WXSceneSession];
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
    SendMessageToWXReq* sendmessageReq = [[SendMessageToWXReq alloc] init];
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *imageObject = [WXImageObject object];
    [imageObject setImageData:UIImageJPEGRepresentation(image, 1)];
    [message setThumbImage:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.3)]];
    [message setMediaObject:imageObject];
    [sendmessageReq setBText:NO];
    [sendmessageReq setMessage:message];
    [sendmessageReq setScene:scene];
    [WXApi sendReq:sendmessageReq];
}

-(void) onResp:(BaseResp*)resp {
    self.resultBlock(resp.errStr);
}

@end
