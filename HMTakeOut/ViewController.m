//
//  ViewController.m
//  HMTakeOut
//
//  Created by Shenzhen_iOS_07 on 16/9/21.
//  Copyright © 2016年 Shenzhen_iOS_07. All rights reserved.
//

#import "ViewController.h"
#import "HMSpu.h"
#import "HMSpuCell.h"
#import "HMSku.h"
#import "HMSkuCell.h"

typedef NS_ENUM(NSInteger, TableViewTag) {
    kSpuTableViewTag = 1,
    kSkuTableViewTag
};

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy) NSArray<HMSpu *> *spus;

@property (weak, nonatomic) IBOutlet UITableView *spuTableView;

@property (weak, nonatomic) IBOutlet UITableView *skuTableView;

@property(nonatomic, assign)CGFloat lastPostionY;
//是否是向上滑动
@property(nonatomic, assign)BOOL isUp;

@property(nonatomic, assign)BOOL isSpuCellSelectedByUser;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.spuTableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    self.spuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.skuTableView.estimatedRowHeight = 180;
    
    self.skuTableView.rowHeight = UITableViewAutomaticDimension;
}

/** 懒加载读取plist，并讲Spu字典数组转换为Spu的模型对象数组 */
-(NSArray *)spus{
    
    if(!_spus){
        
        //获取plist文件的路径
       NSString *path = [[NSBundle mainBundle] pathForResource:@"spus.plist" ofType:nil];
        
        //把plist读取成Array
       NSArray *spusDics = [NSArray arrayWithContentsOfFile:path];
        
        //保存字典转换过来的Spu模型对象
        NSMutableArray *spus = [NSMutableArray arrayWithCapacity:spusDics.count];
        
        //遍历字典数组，并且把字典数组转换为模型数组
        for (NSDictionary *dic in spusDics) {
         
            HMSpu *spu = [HMSpu spuWithDic:dic];
            
            //spu.skus读取出来的是字典数组
            NSArray<NSDictionary *> *skuDics = spu.skus;
            
            //创建一个可变数组，保存Sku的模型对象
            NSMutableArray *skus = [NSMutableArray arrayWithCapacity:skuDics.count];
            
            //sku.skus的字典数组中的所有的字典转换为模型对象
            [skuDics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger index, BOOL * _Nonnull stop) {
                
                HMSku *sku = [HMSku skuWithDic:dic];
                            
                //把转换的模型对象放进前面创建的Sku模型对象数组
                [skus addObject:sku];
            }];

            //让spu.skus的指针指向保存了Sku模型对象数组，这样spu.skus中的每一个元素都是Sku模型对象
            spu.skus = skus;
            
            [spus addObject:spu];
        }
    
        _spus = spus;
    }
    return _spus;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   CGFloat currentY = scrollView.contentOffset.y;
    //用当前位置和前一个滚动位置做比较，如果为正值，向上滑动，如果是负值，向下滑动
   CGFloat deltaY = currentY - self.lastPostionY;
    if(deltaY > 0){
        self.isUp = YES;
    }else{
        self.isUp = NO;
    }
    
    self.lastPostionY = currentY;
//    NSLog(@"deltaY = %f", deltaY);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView.tag == kSpuTableViewTag){//如果是SpuTableView
        
        return self.spus.count; // 返回SpuTableView的每个分组的行数
    }else{

       return self.spus[section].skus.count;//返回SkuTableView每个分组的行数
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if(tableView.tag == kSpuTableViewTag){//如果是SpuTableView,返回一个分组
        
        return 1;
    }else{
    
        return self.spus.count;//返回SkuTableView组数
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag == kSpuTableViewTag){
        self.isSpuCellSelectedByUser = YES;
        [self.skuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}

//设置SkuTableView的headerInSection的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if(tableView.tag == kSkuTableViewTag){
       return self.spus[section].name;
    }
    
    return nil;
}



-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    if(self.isSpuCellSelectedByUser){
        return;
    }
    
    if(self.isUp){
        
        NSLog(@"SpuTableView即将显示的是第%ld行", section + 1);
        
        [self.spuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    }
    
    NSLog(@"第%ld组结束显示 ", section);
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    if(self.isSpuCellSelectedByUser){
        self.isSpuCellSelectedByUser = NO;
        return;
    }
    
    if(tableView.tag == kSkuTableViewTag){
    
        UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
        
        headerView.textLabel.font = [UIFont systemFontOfSize:14];
        
        if(!self.isUp){
            [self.spuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
        
        NSLog(@"即将显示第%ld分组 ", section);
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger tableViewTag = tableView.tag;
    
    if(tableViewTag == kSkuTableViewTag){//如果是SkuTableView,返回skuCell
    
        HMSkuCell *skuCell = [tableView dequeueReusableCellWithIdentifier:@"skuCellID"];
        
        skuCell.sku = self.spus[indexPath.section].skus[indexPath.row];
        
       return skuCell;
        
    }else{//如果是SpuTableView,返回spuCell
        
       HMSpuCell *spuCell = [tableView dequeueReusableCellWithIdentifier:@"spuCellID"];
        
        spuCell.spu = self.spus[indexPath.row];
        
        return spuCell;
    }
}

@end
