//
//  HMSpu.h
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSpu : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,assign)BOOL selected;
@property (nonatomic,assign)NSInteger sequence;

@property (nonatomic,copy)NSArray *skus;

+(instancetype)spuWithDic:(NSDictionary *)dic;

@end
