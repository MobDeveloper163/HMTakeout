//
//  HMSku.h
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSku : NSObject

@property (nonatomic,copy)NSString *describe;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *picture;
@property (nonatomic,assign)NSInteger monthSaled;
@property (nonatomic,copy)NSString *monthSaledContent;
@property (nonatomic,assign)float price;
@property (nonatomic,assign)float originPrice;
@property (nonatomic,assign)NSInteger praiseNum;
@property (nonatomic,copy)NSString *promotionInfo;
@property (nonatomic,assign)NSInteger id;

+(instancetype)skuWithDic:(NSDictionary *)dic;

@end
