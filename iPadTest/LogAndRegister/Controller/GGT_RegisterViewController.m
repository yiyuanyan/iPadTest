//
//  GGT_RegisterViewController.m
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_RegisterViewController.h"
#import "GGT_RegisterView.h"
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
