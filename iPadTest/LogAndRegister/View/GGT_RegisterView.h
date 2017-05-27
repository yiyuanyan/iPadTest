//
//  GGT_RegisterView.h
//  iPadTest
//
//  Created by Talk GoGo on 2017/5/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGT_RegisterView : UIView <UITextFieldDelegate>
//返回按钮
@property(nonatomic, strong) UIButton *backButton;
//phoneView
@property(nonatomic, strong) UIView *phoneView;
//phoneIcon
@property(nonatomic, strong) UIImageView *phoneIcon;
//phoneLine
@property(nonatomic, strong) UIView *phoneLine;
//phoneTextField
@property(nonatomic, strong) UITextField *phoneTextField;

//pwdView
@property(nonatomic, strong) UIView *passwordView;
//pwdIcon
@property(nonatomic, strong) UIImageView *passwordIcon;
//pwdLine
@property(nonatomic, strong) UIView *passwordLine;
//pwdTextField
@property(nonatomic, strong) UITextField *passwordTextField;

//RegButton
@property(nonatomic, strong) UIButton *registerButton;
@end
