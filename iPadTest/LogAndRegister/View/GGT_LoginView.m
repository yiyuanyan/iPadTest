//
//  GGT_LoginView.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_LoginView.h"

@implementation GGT_LoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initLoginView];
    }
    return self;
}
-(void)initLoginView
{
    /* -----------------底部背景设置---------------------- */
    UIImageView *footerImageView = [UIImageView new];
    footerImageView.image = [UIImage imageNamed:@"tob_background"];;
    [self addSubview:footerImageView];
    [footerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.size.mas_offset(CGSizeMake(LineW(1024), LineH(302)));
    }];
    /* -----------------LOGO设置---------------------- */
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = UIIMAGE_FROM_NAME(@"logo");
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LineH(52));
        make.width.mas_equalTo(LineW(175));
        make.top.equalTo(self.mas_top).with.offset(LineY(60));
        make.centerX.equalTo(self.mas_centerX);
    }];
    /* -----------------手机号设置---------------------- */
    UIView *phoneView = [UIView new];
    phoneView.layer.masksToBounds = YES;
    phoneView.layer.borderWidth = 1;
    phoneView.layer.cornerRadius = 6;
    phoneView.layer.borderColor = UICOLOR_FROM_HEX(0xc40016).CGColor;
    self.phoneView = phoneView;
    [self addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(logoImageView.mas_bottom).with.offset(LineY(40));
        make.size.mas_offset(CGSizeMake(LineW(336), LineH(44)));
    }];
    //手机号码icon
    UIImageView *phoneIcon = [[UIImageView alloc] init];
    phoneIcon.image = UIIMAGE_FROM_NAME(@"iPone_have");
    [phoneView addSubview:phoneIcon];
    self.phoneIcon = phoneIcon;
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView.mas_centerY);
        make.left.equalTo(phoneView.mas_left).with.offset(LineX(15));
        make.size.mas_offset(CGSizeMake(LineW(14), LineH(20)));
    }];
    //手机号码分割线
    UIView *phoneLine = [UIView new];
    phoneLine.backgroundColor = UICOLOR_FROM_HEX(0xc40016);
    [phoneView addSubview:phoneLine];
    self.phoneLine = phoneLine;
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(phoneView.mas_height);
        make.top.equalTo(phoneView.mas_top).with.offset(0);
        make.bottom.equalTo(phoneView.mas_bottom).with.offset(0);
        make.left.equalTo(phoneIcon.mas_right).with.offset(LineX(14));
    }];
    //手机号码TextField
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"请输入手机号码";
    phoneTextField.backgroundColor = [UIColor whiteColor];
    [phoneView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLine.mas_right).with.offset(15);
        make.top.equalTo(phoneView.mas_top).with.offset(0);
        make.bottom.equalTo(phoneView.mas_bottom).with.offset(0);
        make.right.equalTo(phoneView.mas_right).with.offset(0);
    }];
    /* -----------------密码输入框---------------------- */
    UIView *passwordView = [[UIView alloc] init];
    passwordView.layer.masksToBounds = YES;
    passwordView.layer.borderWidth = 1;
    passwordView.layer.cornerRadius = 6;
    passwordView.layer.borderColor = UICOLOR_FROM_HEX(0xd5d5d5).CGColor;
    [self addSubview:passwordView];
    self.passwordView = passwordView;
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).with.offset(LineY(30));
        make.centerX.equalTo(phoneView.mas_centerX);
        make.height.mas_equalTo(LineH(44));
        make.left.mas_equalTo(phoneView.mas_left);
        make.right.mas_equalTo(phoneView.mas_right);
    }];
    //密码icon
    self.passwordIcon = [[UIImageView alloc] init];
    self.passwordIcon.image = UIIMAGE_FROM_NAME(@"Password_not");
    [self.passwordView addSubview:self.passwordIcon];
    [self.passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.phoneIcon.mas_left);
        make.centerY.equalTo(self.passwordView.mas_centerY);
        make.left.equalTo(self.passwordView.mas_left).with.offset(LineX(16));
        make.height.mas_equalTo(LineH(20));
        make.width.mas_equalTo(LineW(13));
    }];
    //密码分割线
    self.passwordLine = [[UIView alloc] init];
    self.passwordLine.backgroundColor = UICOLOR_FROM_HEX(0xd5d5d5);
    [self.passwordView addSubview:self.passwordLine];
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLine.mas_left).with.offset(0);
        make.height.equalTo(self.passwordView.mas_height);
        make.width.mas_equalTo(1);
        make.top.equalTo(self.passwordView.mas_top);
        make.bottom.equalTo(self.passwordView.mas_bottom);
    }];
    //密码TextField
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    [self.passwordView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField.mas_left);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.top.equalTo(self.passwordView.mas_top);
        make.bottom.equalTo(self.passwordView.mas_bottom);
    }];
}
@end
