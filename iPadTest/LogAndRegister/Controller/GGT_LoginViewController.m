//
//  GGT_LoginViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_LoginViewController.h"
#import "GGT_ForgotPasswordViewController.h"
#import "GGT_RegisterViewController.h"
#import "GGT_HomeViewController.h"
#import "GGT_LoginView.h"
@interface GGT_LoginViewController ()
@property(nonatomic, strong) GGT_LoginView *loginView;
@property(nonatomic, strong) GGT_Singleton *singleton;
@end

@implementation GGT_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginView = [GGT_LoginView new];
    self.loginView.backgroundColor = [UIColor whiteColor];
    self.view = self.loginView;
    
    _singleton = [GGT_Singleton sharedSingleton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
