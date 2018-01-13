//
//  APSharedUtil.h
//  AggregatePay
//
//  Created by BlackAnt on 2018/1/12.
//  Copyright © 2018年 bingtianyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CPSharedResultBlock)(__kindof NSString *message);

@interface APSharedUtil : NSObject 
+ (APSharedUtil *)sharedInstance;
+ (BOOL)ap_openUrl:(NSURL *)url;
+ (void)ap_register:(NSString *)apiKey;
+ (void)ap_sharedWithImage:(UIImage *)image
                   atScens:(int)scene
               resultBlock:(CPSharedResultBlock)block;
@end
