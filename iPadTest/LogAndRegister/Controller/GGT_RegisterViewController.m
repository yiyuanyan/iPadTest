//
//  GGT_RegisterViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_RegisterViewController.h"
#import "GGT_RegisterView.h"
#import "GGT_HomeViewController.h"
@interface GGT_RegisterViewController ()
@property(nonatomic, strong)GGT_RegisterView *registerView;
@property(nonatomic, strong) GGT_Singleton *singleton;
@end

@implementation GGT_RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setLeftBackButton];
    self.registerView = [[GGT_RegisterView alloc] init];
    self.view = self.registerView;
    self.view.backgroundColor = [UIColor whiteColor];
    _singleton = [GGT_Singleton sharedSingleton];
    //返回
    @weakify(self);
    [[self.registerView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.navigationController popViewControllerAnimated:YES];
     }];
    [[self.registerView.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self registerUser];
    }];
    
}
-(void)registerUser
{
    //判断手机号码
    BOOL isPhoneNumber = [NSString xc_isMobilePhone:self.registerView.phoneTextField.text];
    if(isPhoneNumber == NO){
        [MBProgressHUD showMessage:@"请输入有效的手机号码" toView:self.view];
        return ;
    }
    if(self.registerView.passwordTextField.text.length < 6 || self.registerView.passwordTextField.text.length > 12){
        [MBProgressHUD showMessage:@"密码长度在6~12之间" toView:self.view];
        return ;
    }
    //拼接数据
    NSDictionary *params = @{@"UserName":self.registerView.phoneTextField.text,@"Password":self.registerView.passwordTextField.text,@"OrgLink":@""};
    [[BaseService share] requestWithPath:URL_Resigt method:XCHttpRequestPost parameters:params token:NO viewController:self success:^(id responseObject) {
        if([responseObject[@"result"] isEqual: @1]){
            _singleton.userTokenStr = responseObject[@"data"][@"dicRes"][@"userToken"];
            [UserDefaults() setObject:responseObject[@"data"][@"dicRes"][@"userToken"] forKey:@"userToken"];
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
            [self performSelector:@selector(turnToHomeClick) withObject:nil afterDelay:0.0f];
        }else{
            [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        }
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)turnToHomeClick
{
    [UserDefaults() setObject:@"yes" forKey:@"login"];
    [UserDefaults() synchronize];
    GGT_HomeViewController *vc = [[GGT_HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

@end
