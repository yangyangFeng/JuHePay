//
//  CPHD_OCRTool.h
//  CnepayV2
//
//  Created by 沈陈 on 2016/12/30.
//  Copyright © 2016年 Cnepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CPIdentifyInfo : NSObject

/**
 姓名
 */
@property (nonatomic, copy) NSString *identifyName;

/**
 性别
 */
@property (nonatomic, copy) NSString *gender;

/**
 生日
 */
@property (nonatomic, copy) NSString *birthday;

/**
 身份证号
 */
@property (nonatomic, copy) NSString *identifyNumber;

/**
 身份证照片
 */
@property (nonatomic, strong) UIImage *identifyImage;
@end

@interface CPBankCardInfo : NSObject

/**
 银行名称
 */
@property (nonatomic, copy) NSString *bankName;

/**
 卡名称
 */
@property (nonatomic, copy) NSString *cardName;

/**
 卡类型
 */
@property (nonatomic, copy) NSString *cardType;

/**
 卡号
 */
@property (nonatomic, copy) NSString *cardNum;

/**
 有效期
 */
@property (nonatomic, copy) NSString *validDate;

/**
 银行卡照片
 */
@property (nonatomic, strong) UIImage *bankCardImage;

/**
 组织机构代码
 */
@property (nonatomic, copy) NSString *bankOrgcode;

@end

typedef void(^CPIdentifyBlock)(CPIdentifyInfo *identifyInfo);
typedef void(^CPScanError)(NSError *error);
typedef void(^CPBankCardBlock)(CPBankCardInfo *bankCardInfo);

@interface CPHD_OCRTool : NSObject

@property (copy, nonatomic) CPIdentifyBlock identifyBlock;
@property (copy, nonatomic) CPBankCardBlock bankCardBlock;
@property (copy, nonatomic) CPScanError scanError;


/**
 扫描身份证

 @param viewController 从哪个控制器弹出
 @param isFront yes是正面/no 是反面
 @param complete 完成的回调
 @param error 错误的回调
 */
+ (void)presentScanIdentifyFromViewController:(UIViewController *)viewController isFront:(BOOL)isFront complete:(CPIdentifyBlock)complete error:(CPScanError)error;


/**
 扫描银行卡

 @param viewController
 @param complete
 @param error 
 */
+ (void)presentScanBankCardFromViewController:(UIViewController *)viewController complete:(CPBankCardBlock)complete error:(CPScanError)error;
@end
