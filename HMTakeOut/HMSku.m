//
//  HMSku.m
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import "HMSku.h"

@implementation HMSku

+(instancetype)skuWithDic:(NSDictionary *)dic{
    
    HMSku *sku = [[HMSku alloc] init];
    
    [sku setValuesForKeysWithDictionary:dic];
    
    return sku;
}

@end
