//
//  APOCRImageTool.m
//  AggregatePay
//
//  Created by 沈陈 on 2017/12/22.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

#import "APOCRImageTool.h"
#import "IOSOCRAPI.h"
#import "CameraBankDrawView.h"

#define TOP_LINE_EXIST1        (1<<0)//0x0001上边线
#define LEFT_LINE_EXIST1        (1<<1)//0x0010左边线
#define BOTTOM_LINE_EXIST1    (1<<2)//0x0100下边线
#define RIGHT_LINE_EXIST1    (1<<3)//0x1000右边线

@implementation APOCRImageTool

+ (NSDictionary *)handleIDCardData:(UIImage *)image rect:(CGRect)rect drawView:(CameraDrawView *)drawView{
    
    TREC_LoadImage(image);
    int x1 = rect.origin.y;
    int y1 = rect.origin.x;
    int x2 = rect.size.height;
    int y2 = rect.size.width;
    
    int result2 =  TREC_JudgeExist(x1,y1,x2,y2);
    
    int top = (result2 & TOP_LINE_EXIST1)==1?1:0;
    int left = (result2 & LEFT_LINE_EXIST1) ==2?1:0;
    int bottom = (result2 & BOTTOM_LINE_EXIST1) ==4?1:0;
    int right = (result2 & RIGHT_LINE_EXIST1) ==8?1:0;
    int ret = 0;
    int isReturnOk = 0;
    //NSLog(@"(%d %d %d %d)",top,left,bottom,right);
    //至少三边存在
    [drawView showLineUP:left right:top bottom:right left:bottom];
    [drawView setNeedsDisplay];
    if (((top + left + bottom + right)>=3)) {
        int Value[5] = {TIDC_SCAN_MODE,x1,y1,x2-x1,y2-y1};
        int val = 1;
        TREC_SetParam(T_SET_RECMODE,&Value[0]);
        TREC_SetParam(T_SET_AREA_LEFT,&Value[1]);
        TREC_SetParam(T_SET_AREA_TOP,&Value[2]);
        TREC_SetParam(T_SET_AREA_WIDTH,&Value[3]);
        TREC_SetParam(T_SET_AREA_HEIGHT,&Value[4]);
        TREC_SetParam(T_SET_HEADIMG,&val);
        ret = TREC_OCR();
        if(ret == 100)
        {
            NSLog(@"引擎过期");
        }
        isReturnOk = TREC_GetCardNumState();
    }
    TREC_FreeImage();
    
    return @{@"ret": @(ret), @"isReturnOk": @(isReturnOk)};
}

+ (NSDictionary *)handleBankCardData:(UIImage *)image rect:(CGRect)rect drawView:(CameraDrawView *)drawView {
    
    TBANK_LoadImage(image);
    int x1 = rect.origin.y;
    int y1 = rect.origin.x;
    int x2 = rect.size.height;
    int y2 = rect.size.width;
    
    int result2 =  TBANK_JudgeExist(x1,y1,x2,y2);
    
    int top = (result2 & TOP_LINE_EXIST1)==1?1:0;
    int left = (result2 & LEFT_LINE_EXIST1) ==2?1:0;
    int bottom = (result2 & BOTTOM_LINE_EXIST1) ==4?1:0;
    int right = (result2 & RIGHT_LINE_EXIST1) ==8?1:0;
    int ret = 0;
    int isReturnOk = 0;
    //NSLog(@"(%d %d %d %d)",top,left,bottom,right);
    //至少三边存在
    [drawView showLineUP:left right:top bottom:right left:bottom];
    [drawView setNeedsDisplay];
    if (((top + left + bottom + right)>=3) || (top == 1 && bottom == 1) || (left == 1 && right == 1))
    {
        
        ret = TBANK_OCR();
        if(ret == 100)
        {
            NSLog(@"引擎过期");
        }
        isReturnOk = TREC_GetCardNumState();
    }
    TBANK_FreeImage();
    return @{@"ret": @(ret), @"isReturnOk": @(isReturnOk)};
}
@end
