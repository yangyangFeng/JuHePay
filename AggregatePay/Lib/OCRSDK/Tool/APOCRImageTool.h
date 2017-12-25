//
//  APOCRImageTool.h
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/22.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CameraDrawView;
@interface APOCRImageTool : NSObject

//#if !TARGET_IPHONE_SIMULATOR
+ (NSDictionary *)handleIDCardData:(UIImage *)image rect:(CGRect)rect drawView:(CameraDrawView *)drawView;
+ (NSDictionary *)handleBankCardData:(UIImage *)image rect:(CGRect)rect drawView:(CameraDrawView *)drawView;
//#endif
@end
