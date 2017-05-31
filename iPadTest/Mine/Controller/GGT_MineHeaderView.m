//
//  GGT_MineHeaderView.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineHeaderView.h"

@implementation GGT_MineHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor = UICOLOR_RANDOM_COLOR();
}
-(void)getResultModel:(GGT_MineLeftMode *)model
{
    NSLog(@"%@",model);
}
@end
