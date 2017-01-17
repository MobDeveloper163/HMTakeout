//
//  HMSpu.m
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import "HMSpu.h"

@implementation HMSpu

+(instancetype)spuWithDic:(NSDictionary *)dic{
    
    HMSpu *spu = [[HMSpu alloc] init];
    [spu setValuesForKeysWithDictionary:dic];
    return spu;
}

@end
