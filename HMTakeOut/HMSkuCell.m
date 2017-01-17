//
//  HMSkuCell.m
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import "HMSkuCell.h"
#import "HMSku.h"

@interface HMSkuCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *saledLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *origionLabel;

@property (weak, nonatomic) IBOutlet UIButton *promotionBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descTopCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *promotionHeightCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *promotionTopCons;

@end

@implementation HMSkuCell



- (void)awakeFromNib {
    
    [super awakeFromNib];

    self.promotionBtn.userInteractionEnabled = NO;
    
    self.promotionBtn.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    self.selectedBackgroundView = selectedBackgroundView;
}


-(void)setSku:(HMSku *)sku{
    
    _sku = sku;

    NSString *picturePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.jpg",sku.picture] ofType:nil];
    
    self.pictureIV.image = [UIImage imageWithContentsOfFile:picturePath];
    
    self.nameLabel.text = sku.name;
    
    self.descLabel.text = sku.describe;
    
    if(self.descLabel.text == nil || self.descLabel.text.length == 0){
        self.descHeightCons.constant = 0;
        self.descTopCons.constant = 0;
        self.descHeightCons.priority = 999;
        self.descTopCons.priority = 999;
    }else{
        self.descHeightCons.priority = 100;
        self.descTopCons.priority = 100;
    }
    
    self.saledLabel.text = sku.monthSaledContent;
    
    self.praiseLabel.text = [NSString stringWithFormat:@"赞%ld",sku.praiseNum];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", sku.price];
    
    self.origionLabel.text = [NSString stringWithFormat:@"￥%.2f", sku.originPrice];
    
    if(self.sku.promotionInfo == nil || self.sku.promotionInfo.length == 0){
        
        self.promotionBtn.hidden = YES;
        
        self.promotionHeightCons.constant = 0;
        
        self.promotionHeightCons.priority = 999;
        
        self.promotionTopCons.constant = 0;
        
        self.promotionTopCons.priority = 999;
        
    }else{
        
        self.promotionHeightCons.priority = 100;
        
        self.promotionTopCons.priority = 100;
        
        self.promotionBtn.hidden = NO;
        
        [self.promotionBtn setTitle:self.sku.promotionInfo forState:UIControlStateNormal];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
