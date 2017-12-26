//
//  APClassRuntimeTool.m
//  AggregatePay
//
//  Created by BlackAnt on 2017/12/25.
//  Copyright © 2017年 bingtianyu. All rights reserved.
//

#import "APClassRuntimeTool.h"
#import <MJExtension/MJExtension.h>

@implementation APClassRuntimeTool

+ (id)ap_class:(Class)ofClass result:(id)result {
    return [ofClass mj_objectWithKeyValues:result];
}

@end
