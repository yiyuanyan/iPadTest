//
//  GGT_HomeLeftView.m
//  iPadTest
//
//  Created by Talk GoGo on 2017/5/27.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_HomeLeftView.h"

@implementation GGT_HomeLeftView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor = UICOLOR_FROM_HEX(0x2C2C2C);
    //logo
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = UIIMAGE_FROM_NAME(@"logo_daohanglan");
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(LineY(32));
        make.size.mas_offset(CGSizeMake(LineW(68), LineH(21)));
    }];
    
    self.optionsView = [[UIView alloc] init];
    [self addSubview:self.optionsView];
    [self.optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(LineY(163));
        make.height.mas_offset(LineH(166));
    }];
    //课表按钮
    UIButton *scheduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scheduleButton setTitle:@"课表" forState:UIControlStateNormal];
    scheduleButton.frame = CGRectMake(0, 0, LineW(88), LineH(55));
    [scheduleButton setImage:UIIMAGE_FROM_NAME(@"kebiao_wei") forState:UIControlStateNormal];
    [scheduleButton setImage:UIIMAGE_FROM_NAME(@"kebiao") forState:UIControlStateSelected];
    scheduleButton.tag = 100;
    scheduleButton.selected = YES;
    [scheduleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self initButton:scheduleButton];
    [self.optionsView addSubview:scheduleButton];
    [scheduleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.optionsView.mas_centerX);
        make.top.equalTo(self.optionsView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(LineW(88), LineH(55)));
    }];
    //我的按钮
    UIButton *mineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mineButton setTitle:@"我的" forState:UIControlStateNormal];
    mineButton.frame = CGRectMake(0, 0, LineW(88), LineH(57));
    [mineButton setImage:UIIMAGE_FROM_NAME(@"wode") forState:UIControlStateNormal];
    [mineButton setImage:UIIMAGE_FROM_NAME(@"wode_yi") forState:UIControlStateSelected];
    mineButton.tag = 101;
    mineButton.selected = NO;
    [mineButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self initButton:mineButton];
    [self.optionsView addSubview:mineButton];
    [mineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.optionsView.mas_centerX);
        make.bottom.equalTo(self.optionsView.mas_bottom).with.offset(-0);
        make.size.mas_equalTo(CGSizeMake(LineW(88), LineH(57)));
    }];
    //检测按钮
    UIButton *jianceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jianceButton setImage:UIIMAGE_FROM_NAME(@"jiance") forState:UIControlStateNormal];
    jianceButton.tag = 102;
    [jianceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:jianceButton];
    [jianceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineButton.mas_bottom).with.offset(LineY(328));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(LineW(27), LineH(27)));
    }];
    //客服按钮
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneButton setImage:UIIMAGE_FROM_NAME(@"kefu") forState:UIControlStateNormal];
    phoneButton.tag = 103;
    [phoneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:phoneButton];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jianceButton.mas_bottom).with.offset(LineY(30));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(LineW(26), LineH(26)));
    }];
}
//按钮图片文字位置
-(void)initButton:(UIButton *)btn{
    //设置按钮的字体选中颜色
    [btn setTitleColor:UICOLOR_FROM_HEX(0x777777) forState:UIControlStateNormal];
    [btn setTitleColor:UICOLOR_FROM_HEX(0xC40016) forState:UIControlStateSelected];
    btn.titleLabel.font = Font(12);
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGFloat totalHeight = LineH(55);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - LineH(imageSize.height)), 0.0, 0.0, - LineW(titleSize.width));
    btn.titleEdgeInsets = UIEdgeInsetsMake(LineH(7), - LineW(imageSize.width), - ((totalHeight-LineH(17)) ), 0);
}
-(void)buttonAction:(UIButton *)button{
    if([self.optionsView.subviews containsObject:button]){
        for (UIView *view in self.optionsView.subviews) {
            if([view isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton *)view;
                btn.selected = NO;
            }
        }
    }
    button.selected = YES;
    if(self.buttonClickBlock){
        self.buttonClickBlock(button);
    }
}
@end
