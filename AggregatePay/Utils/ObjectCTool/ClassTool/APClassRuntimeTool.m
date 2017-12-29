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
+(NSMutableArray *)mj_objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context{
    return [super mj_objectArrayWithKeyValuesArray:keyValuesArray context:context];
}
@end
