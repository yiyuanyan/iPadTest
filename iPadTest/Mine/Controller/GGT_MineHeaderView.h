//
//  GGT_MineHeaderView.h
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGT_MineLeftMode.h"
@interface GGT_MineHeaderView : UIView
//头像
@property(nonatomic, strong)UIImageView *headImgView;
//姓名
@property(nonatomic, strong) UILabel *nameLabel;
//VIP
@property(nonatomic, strong) UIImageView *VIPImgView;
//英语等级
@property(nonatomic, strong) UILabel *levelLabel;
//已说英语
@property(nonatomic, strong) UILabel *speakLabel;
//迟到
@property(nonatomic, strong) UILabel *laterLabel;
//缺席
@property(nonatomic, strong) UILabel *absentLabel;
-(void)getResultModel:(GGT_MineLeftMode *)model;
@end
