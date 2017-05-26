//
//  GGT_RegisterView.m
//  iPadTest
//
//  Created by Talk GoGo on 2017/5/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_RegisterView.h"

@implementation GGT_RegisterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initRegisterView];
    }
    return self;
}
-(void)initRegisterView
{
    /* ----------------------返回按钮------------------------------ */
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"return_red"] forState:UIControlStateNormal];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(LineX(21));
        make.top.equalTo(self.mas_top).with.offset(LineY(33));
        make.size.mas_offset(CGSizeMake(LineW(11), LineH(18)));
    }];
    /* ----------------------LogoView------------------------------ */
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = UIIMAGE_FROM_NAME(@"logo");
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(LineH(60));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(LineW(175), LineH(52)));
    }];
    /* -----------------底部背景设置---------------------- */
    UIImageView *footerImageView = [UIImageView new];
    footerImageView.image = [UIImage imageNamed:@"tob_background"];;
    [self addSubview:footerImageView];
    [footerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.size.mas_offset(CGSizeMake(LineW(1024), LineH(302)));
    }];
    /* -----------------手机号码---------------------- */
    self.phoneView = [[UIView alloc] init];
    self.phoneView.layer.masksToBounds = YES;
    self.phoneView.layer.borderColor = UICOLOR_FROM_HEX(ColorD5D5D5).CGColor;
    self.phoneView.layer.borderWidth = 1;
    self.phoneView.layer.cornerRadius = 6;
    [self addSubview:self.phoneView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).with.offset(LineY(40));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(LineW(336), LineH(44)));
    }];
    //手机号码icon
    self.phoneIcon = [[UIImageView alloc] init];
    self.phoneIcon.image = UIIMAGE_FROM_NAME(@"iPone_not");
    [self.phoneView addSubview:self.phoneIcon];
    [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneView.mas_centerY);
        make.left.equalTo(self.phoneView.mas_left).with.offset(LineX(15));
    }];
}

@end
