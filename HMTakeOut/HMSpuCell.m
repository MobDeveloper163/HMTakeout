//
//  HMSpuCell.m
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import "HMSpuCell.h"
#import "HMSpu.h"

@interface HMSpuCell ()

@property (weak, nonatomic) IBOutlet UIButton *spuTitleBtn;

@end

@implementation HMSpuCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.spuTitleBtn.userInteractionEnabled = NO;
    
    self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    
    selectedBackgroundView.backgroundColor = [UIColor redColor];
    
    self.selectedBackgroundView = selectedBackgroundView;
    
    self.spuTitleBtn.titleLabel.numberOfLines = 0;
    
    self.spuTitleBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.spuTitleBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
}

-(void)setSpu:(HMSpu *)spu{
    
    _spu = spu;
    
    [self.spuTitleBtn setTitle:spu.name forState:UIControlStateNormal];
    
    if(spu.icon != nil && spu.icon.length != 0){
        [self.spuTitleBtn setImage:[UIImage imageNamed:spu.icon] forState:UIControlStateNormal];
    }else{
        [self.spuTitleBtn setImage:nil forState:UIControlStateNormal];
    }

}

@end
