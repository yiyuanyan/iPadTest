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
    //手机号码分割线
    self.phoneLine = [[UIView alloc] init];
    self.phoneLine.backgroundColor = UICOLOR_FROM_HEX(ColorD5D5D5);
    [self.phoneView addSubview:self.phoneLine];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneIcon.mas_right).with.offset(LineX(14));
        make.top.equalTo(self.phoneView.mas_top).with.offset(0);
        make.bottom.equalTo(self.phoneView.mas_bottom).with.offset(0);
        make.size.mas_offset(CGSizeMake(LineW(1), LineH(44)));
    }];
    //手机号码TextField
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.placeholder = @"请输入手机号码";
    self.phoneTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLine.mas_right).with.offset(LineX(22));
        make.top.equalTo(self.phoneView.mas_top).with.offset(0);
        make.right.equalTo(self.phoneView.mas_right).with.offset(0);
        make.bottom.equalTo(self.phoneView.mas_bottom).with.offset(0);
    }];
    
    /* -----------------密码View---------------------- */
    self.passwordView = [[UIView alloc] init];
    //self.passwordView.backgroundColor = UICOLOR_FROM_HEX(ColorD5D5D5);
    self.passwordView.layer.masksToBounds = YES;
    self.passwordView.layer.borderWidth = 1;
    self.passwordView.layer.borderColor = UICOLOR_FROM_HEX(ColorD5D5D5).CGColor;
    self.passwordView.layer.cornerRadius = 6;
    [self addSubview:self.passwordView];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).with.offset(LineY(30));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(LineW(336), LineH(44)));
    }];
    //密码icon
    self.passwordIcon = [[UIImageView alloc] init];
    self.passwordIcon.image = UIIMAGE_FROM_NAME(@"Password_not");
    [self.passwordView addSubview:self.passwordIcon];
    [self.passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordView.mas_left).with.offset(LineX(15));
        make.centerY.mas_equalTo(self.passwordView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(LineW(12), LineH(20)));
    }];
    //密码分割线
    self.passwordLine = [[UIView alloc] init];
    self.passwordLine.backgroundColor = UICOLOR_FROM_HEX(ColorD5D5D5);
    [self.passwordView addSubview:self.passwordLine];
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordIcon.mas_right).with.offset(LineX(15));
        make.size.mas_offset(CGSizeMake(LineW(1), LineH(44)));
        make.top.equalTo(self.passwordView.mas_top).with.offset(0);
    }];
    //密码TextField
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordLine.mas_right).with.offset(LineX(22));
        make.top.equalTo(self.passwordView.mas_top).with.offset(0);
        make.right.equalTo(self.passwordView.mas_right).with.offset(0);
        make.bottom.equalTo(self.passwordView.mas_bottom).with.offset(0);
    }];
    /* -----------------注册Button---------------------- */
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.backgroundColor = UICOLOR_FROM_HEX(ColorC40016);
    [self.registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 22;
    [self addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom).with.offset(LineY(40));
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_offset(CGSizeMake(LineW(324), LineH(44)));
    }];
}
#pragma make --  TextField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.phoneTextField){
        self.phoneView.layer.borderColor = UICOLOR_FROM_HEX(ColorC40016).CGColor;
        self.phoneLine.backgroundColor = UICOLOR_FROM_HEX(ColorC40016);
        self.phoneIcon.image = UIIMAGE_FROM_NAME(@"iPone_have");
    }else{
        self.passwordView.layer.borderColor = UICOLOR_FROM_HEX(ColorC40016).CGColor;
        self.passwordIcon.image = UIIMAGE_FROM_NAME(@"Password_have");
        self.passwordLine.backgroundColor = UICOLOR_FROM_HEX(ColorC40016);
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.phoneTextField){
        self.phoneView.layer.borderColor = UICOLOR_FROM_HEX(ColorD5D5D5).CGColor;
        self.phoneLine.backgroundColor = UICOLOR_FROM_HEX(ColorD5D5D5);
        self.phoneIcon.image = UIIMAGE_FROM_NAME(@"iPone_not");
    }else{
        self.passwordView.layer.borderColor = UICOLOR_FROM_HEX(ColorD5D5D5).CGColor;
        self.passwordLine.backgroundColor = UICOLOR_FROM_HEX(ColorD5D5D5);
        self.passwordIcon.image = UIIMAGE_FROM_NAME(@"Password_not");
    }
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if(textField == self.phoneTextField){
        if(self.phoneTextField.text.length > 11){
            [self.phoneTextField.text substringToIndex:11];
        }
    }else{
        if(self.passwordTextField.text.length > 12){
            [self.passwordTextField.text substringToIndex:12];
        }
    }
}
@end
