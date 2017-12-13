//
//  CPHD_OCRTool.m
//  CnepayV2
//
//  Created by 沈陈 on 2016/12/30.
//  Copyright © 2016年 Cnepay. All rights reserved.
 
// typedef enum
// {
//	TUNCERTAIN	  = 0x00,   /*未知*/
//TIDCARD2        = 0x11,   /*二代证*/
//TIDCARDBACK    = 0x14,   /*二代证背面*/
//TIDBANK         = 0x15,   /*银行卡*/
//TIDLPR           = 0x16,   /*车牌*/
//TIDJSZCARD      = 0x17,   /*驾照*/
//TIDXSZCARD     = 0x18,   /*行驶证*/
//TIDTICKET	      = 0x19,   /*行驶证*/
//TIDSSCCARD	  = 0x20,   /*社保卡*/
//TIDPASSPORT	  = 0x21,	/*护照*/
//} TCARD_TYPE; // 后面设置证件界面是通过这个区分的 */


#import "CPHD_OCRTool.h"
#import "Globaltypedef.h"
#import "SCCaptureCameraController.h"
#import "SCNavigationController.h"

@interface CPHD_OCRTool ()<SCNavigationControllerDelegate>

@property (nonatomic, strong) CPBankCardInfo *cardInfo;
@property (nonatomic, strong) CPIdentifyInfo *identifyInfo;


@end
@implementation CPHD_OCRTool

+ (CPHD_OCRTool *)tool {
    static CPHD_OCRTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[CPHD_OCRTool alloc]init];
    });
    return tool;
}

#pragma mark - ****************************************** 扫描身份证

+ (void)presentScanIdentifyFromViewController:(UIViewController *)viewController isFront:(BOOL)isFront complete:(CPIdentifyBlock)complete error:(CPScanError)error
{
    CPHD_OCRTool *tool = [CPHD_OCRTool tool];
    
    SCCaptureCameraController *captureCameraController = [tool createCaptureCameraController];
    captureCameraController.iCardType = isFront ? TIDCARD2 : TIDCARDBACK;
    captureCameraController.ScanMode = TIDC_SCAN_MODE;
    [viewController presentViewController:captureCameraController animated:YES completion:nil];
    
    tool.identifyBlock = ^(CPIdentifyInfo *identifyInfo) {
        if (identifyInfo.identifyImage && identifyInfo.identifyNumber && identifyInfo.identifyName) {
            if (complete) {
                complete(identifyInfo);
            }
        }
    };
    
//    NSError *failedError = [NSError errorWithDomain:@"扫描身份证已取消" code:-2 userInfo:nil];
//    if (error) {
//        error(failedError);
//    }
}



#pragma mark - ****************************************** 扫描银行卡

+ (void)presentScanBankCardFromViewController:(UIViewController *)viewController complete:(CPBankCardBlock)complete error:(CPScanError)error
{
    CPHD_OCRTool *tool = [CPHD_OCRTool tool];
    SCCaptureCameraController *captureCameraController = [tool createCaptureCameraController];
    captureCameraController.iCardType = TIDBANK;
    [viewController presentViewController:captureCameraController animated:YES completion:nil];
    
    tool.bankCardBlock = ^(CPBankCardInfo *bankCardInfo) {
        if (bankCardInfo.bankCardImage && bankCardInfo.cardNum) {
            if (complete) {
                complete(bankCardInfo);
            }
        }
    };
    
//    NSError *failedError = [NSError errorWithDomain:@"扫描银行卡已取消" code:-2 userInfo:nil];
//    if (error) {
//        error(failedError);
//    }
}


#pragma mark - ******************************************

// 银行卡信息
- (void)sendBankCardInfo:(NSString *)bank_num BANK_NAME:(NSString *)bank_name BANK_ORGCODE:(NSString *)bank_orgcode BANK_CLASS:(NSString *)bank_class CARD_NAME:(NSString *)card_name
{
    NSString *astring = [[NSString alloc] initWithString:[NSString stringWithFormat:@"卡号  ： %@\n发卡行 ： %@\n机构代码： %@\n卡种  ： %@\n卡名  ： %@\n",bank_num,bank_name,bank_orgcode,bank_class,card_name]];
    NSLog(@"BANK INFO = %@\n",astring);
    
    self.cardInfo.cardNum = bank_num;
    self.cardInfo.bankName = bank_name;
    self.cardInfo.bankOrgcode = bank_orgcode;
    self.cardInfo.cardType = bank_class;
    self.cardInfo.cardName = card_name;
    
    self.bankCardBlock(self.cardInfo);
}

//获取银行卡图片
- (void)sendBankCardImage:(UIImage *)BankCardImage {
    self.cardInfo.bankCardImage = BankCardImage;
    self.bankCardBlock(self.cardInfo);
}

//获取拍照的图片
- (void)sendTakeImage:(TCARD_TYPE) iCardType image:(UIImage *)cardImage
{
    self.identifyInfo.identifyImage = cardImage;
    
    self.identifyBlock(self.identifyInfo);
}

// 获取身份证正面信息
- (void)sendIDCValue:(NSString *)name SEX:(NSString *)sex FOLK:(NSString *)folk BIRTHDAY:(NSString *)birthday ADDRESS:(NSString *) address NUM:(NSString *)num
{
    self.identifyInfo.identifyName = name;
    self.identifyInfo.gender = sex;
    self.identifyInfo.birthday = birthday;
    self.identifyInfo.identifyNumber = num;
    
    self.identifyBlock(self.identifyInfo);
    
}


#pragma mark - ****************************************** Get

- (SCCaptureCameraController *)createCaptureCameraController {
    
    SCCaptureCameraController *captureCameraController = [[SCCaptureCameraController alloc]init];
//    captureCameraController.TimeKey = @"eaedf2b4cb679a6af248a862f5a1fe18";
    captureCameraController.isDisPlayTxt = YES;
    captureCameraController.scNaigationDelegate = self;
    return captureCameraController;
}

- (CPBankCardInfo *)cardInfo {
    if (!_cardInfo) {
        _cardInfo = [[CPBankCardInfo alloc]init];
    }
    return _cardInfo;
}

- (CPIdentifyInfo *)identifyInfo {
    if(!_identifyInfo) {
        _identifyInfo = [[CPIdentifyInfo alloc]init];
    }
    return _identifyInfo;
}

@end

@implementation CPIdentifyInfo
@end
@implementation CPBankCardInfo
@end
