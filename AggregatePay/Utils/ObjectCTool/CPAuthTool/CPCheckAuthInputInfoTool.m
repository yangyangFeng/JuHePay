//
//  CPCheckAuthInputInfoTool.m
//  CnepayV2
//
//  Created by Cnepay on 15/12/16.
//  Copyright (c) 2015年 Cnepay. All rights reserved.
//

#import "CPCheckAuthInputInfoTool.h"

@implementation CPCheckAuthInputInfoTool

+ (BOOL) evaluateBankNo:(NSString *)bankNo
{
    NSPredicate *bankNoPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\d{12,24}$"];
    return [bankNoPredicate evaluateWithObject:bankNo];
}


+ (BOOL) evaluateBusinessLicense:(NSString *)businessLicense
{
    NSPredicate *businessLicensePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^\\w{7,30}$"];
    return [businessLicensePredicate evaluateWithObject:businessLicense];
}

+ (BOOL) evaluatePassword:(NSString *)password {
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[a-zA-Z0-9-_]{6,16}$"];
    return [passwordPredicate evaluateWithObject:password];
}

+ (BOOL) evaluatePhoneNumber:(NSString *)phoneNumber {
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^1[3-9]\\d{9}$"];
    return [passwordPredicate evaluateWithObject:phoneNumber];
}

/**
 *  检查真实姓名
 *  @param name 姓名
 *  @return 是否校验成功
 */
+ (BOOL) evaluateIsLegalNameWithName:(NSString *)name {
    NSString *regex = @"^[\u4e00-\u9fa5]+[·•]?[\u4e00-\u9fa5]+$";//支持中文
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:name];
}


/**
 *  检查真实姓名
 *  @param name 姓名
 *  @return 是否校验成功
 */
+ (BOOL) evaluateIsChineseAndEnglishNameWithName:(NSString *)name {
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5]+[·•]?[a-zA-Z0-9\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:name];
}

/**
 *  检查15/18位的身份证号
 *  @param idNo 身份证号
 *  @return 是否成功
 */
+ (BOOL) checkIsIDCardWithIDCard:(NSString *)idNo
{
    if(idNo.length == 15 || idNo.length == 18){
        NSString *emailRegex = @"^[0-9]*$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        bool sfzNo = [emailTest evaluateWithObject:[idNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        if (idNo.length == 15) {
            if (!sfzNo) {
                return NO;
            }else{
                return YES;
            }
        }
        else if (idNo.length == 18) {
            bool sfz18NO = [self checkIsIDCardWithCardNo:idNo];
            if (!sfz18NO) {
                return NO;
            }else{
                return YES;
            }
        }
    }
    
    return NO;
}


/**
 *  检查身份证18位
 *  @param cardNo 身份证
 *  @return 是否成功
 */
+ (BOOL)checkIsIDCardWithCardNo:(NSString *)cardNo{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

+ (BOOL)checkIsMoreThan18WithCardNo:(NSString *)cardNo {
    
    cardNo = [cardNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *fontNumber;
    if (cardNo.length == 15) {
        NSString *age = [cardNo substringWithRange:NSMakeRange(6, 6)];
        fontNumber = [NSString stringWithFormat:@"19%@",age];
    }else if (cardNo.length == 18) {
        NSString *age = [cardNo substringWithRange:NSMakeRange(6, 8)];
        fontNumber = [NSString stringWithFormat:@"%@",age];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *bsyDate = [dateFormatter dateFromString:fontNumber];
    
   NSInteger year = [self daysBetweenDate:bsyDate andDate:[NSDate date]];
    if (year >= 18) {
        return YES;
    }
    return NO;
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    NSDateComponents *difference = [calendar components:NSCalendarUnitYear
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference year];
}

@end
