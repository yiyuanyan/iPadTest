//
//  GGT_LoginView.h
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGT_LoginView : UIView
//手机号码边框
@property(nonatomic, weak) UIView *phoneView;
//手机号码icon
@property(nonatomic, weak)UIImageView *phoneIcon;
//手机号码分割线
@property(nonatomic, weak)UIView *phoneLine;
//手机号码TextField
@property(nonatomic, weak)UITextField *phoneTextField;

//密码边框
@property(nonatomic, weak)UIView *passwordView;
//密码icon
@property(nonatomic, strong)UIImageView *passwordIcon;
//密码分割线
@property(nonatomic, strong) UIView *passwordLine;
//密码TextField
@property(nonatomic, strong) UITextField *passwordTextField;
@end
