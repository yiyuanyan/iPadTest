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
    //忘记密码按钮
    @weakify(self);
    [[self.loginView.forgetPwd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        GGT_ForgotPasswordViewController *vc = [[GGT_ForgotPasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //注册按钮
    [[self.loginView.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        GGT_RegisterViewController *vc = [[GGT_RegisterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //登录按钮
    [[self.loginView.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self userLogin];
    }];
}
//用户登录方法
-(void)userLogin
{
    //判断是否为空
    if(IsStrEmpty(self.loginView.phoneTextField.text)){
        [MBProgressHUD showMessage:@"请输入手机号码" toView:self.view];
        return ;
    }
    //判断填写的是否是手机号码
    BOOL isPhoneNum = [NSString xc_isMobilePhone:self.loginView.phoneTextField.text];
    if(isPhoneNum == NO){
        [MBProgressHUD showMessage:@"请输入有效手机号码" toView:self.view];
        return ;
    }
    //密码验证
    if(IsStrEmpty(self.loginView.passwordTextField.text) || self.loginView.passwordTextField.text.length < 6 || self.loginView.passwordTextField.text.length > 12){
        [MBProgressHUD showMessage:@"输入的密码位数必须6~12位" toView:self.view];
        return ;
    }
    //拼接数据
    NSDictionary *dic = @{@"UserName":self.loginView.phoneTextField.text,@"Password":self.loginView.passwordTextField.text,@"OrgLink":@""};
    [[BaseService share] requestWithPath:URL_Login method:XCHttpRequestPost parameters:dic token:NO viewController:self success:^(id responseObject) {
        if([responseObject[@"result"] isEqual: @1]){
            _singleton.userTokenStr = responseObject[@"data"][@"dicRes"][@"userToken"];
            [UserDefaults() setObject:responseObject[@"data"][@"dicRes"][@"userToken"] forKey:@"userToken"];
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
            [self performSelector:@selector(turnToHomeClick) withObject:nil afterDelay:0.0f];
        }else{
            [MBProgressHUD showMessage:responseObject[@"mgs"] toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)turnToHomeClick{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"yes" forKey:@"login"];
    GGT_HomeViewController *vc = [[GGT_HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
